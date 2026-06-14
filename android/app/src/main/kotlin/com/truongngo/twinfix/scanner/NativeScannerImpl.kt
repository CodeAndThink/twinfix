package com.truongngo.twinfix.scanner

import android.content.ContentResolver
import android.content.ContentUris
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.util.Log
import android.util.Size
import io.flutter.plugin.common.BinaryMessenger
import kotlinx.coroutines.*
import java.io.File
import java.util.concurrent.atomic.AtomicBoolean
import kotlinx.coroutines.SupervisorJob

/**
 * Native implementation of the Pigeon ScannerHostApi.
 * Runs all heavy image processing on background threads via Kotlin Coroutines,
 * keeping the Flutter Main Isolate completely free for UI/animation rendering.
 */
class NativeScannerImpl(
    private val context: Context,
    private val binaryMessenger: BinaryMessenger
) : ScannerHostApi {

    companion object {
        private const val TAG = "NativeScanner"
    }

    private val isCancelled = AtomicBoolean(false)
    private var scanJob: Job? = null
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val flutterApi = ScannerFlutterApi(binaryMessenger)

    override fun scanAssets(
        assetIds: List<String>,
        config: NativeScanConfig,
        callback: (Result<List<NativeScanResult>>) -> Unit
    ) {
        // Cancel any previously running scan before starting a new one
        scanJob?.cancel()
        isCancelled.set(false)

        scanJob = scope.launch {
            try {
                val results = processAssets(assetIds, config)
                withContext(Dispatchers.Main) {
                    callback(Result.success(results))
                }
            } catch (e: CancellationException) {
                withContext(Dispatchers.Main) {
                    callback(Result.success(emptyList()))
                }
            } catch (e: Exception) {
                Log.e(TAG, "Scan failed", e)
                withContext(Dispatchers.Main) {
                    callback(Result.failure(
                        FlutterError("SCAN_ERROR", e.message, e.stackTraceToString())
                    ))
                }
            }
        }
    }

    override fun cancelScan() {
        isCancelled.set(true)
        scanJob?.cancel()
        scanJob = null
        Log.d(TAG, "Scan cancelled")
    }

    override fun getAssetLatLng(filePath: String): NativeLatLng? {
        val latLng = ImageAnalyzer.getLatLng(filePath)
        if (latLng != null) {
            return NativeLatLng(latLng[0], latLng[1])
        }
        return null
    }

    /**
     * Clean up coroutine scope when FlutterEngine is detached.
     * Prevents orphaned coroutines from running after engine destruction.
     */
    fun dispose() {
        isCancelled.set(true)
        scope.cancel()
        Log.d(TAG, "NativeScanner disposed")
    }

    // ===================== Core Processing =====================

    private suspend fun processAssets(
        assetIds: List<String>,
        config: NativeScanConfig
    ): List<NativeScanResult> {
        val contentResolver = context.contentResolver
        val total = assetIds.size.toLong()
        val processedAssets = mutableListOf<AssetData>()

        // Phase 1: Load metadata + thumbnails and compute per-image features
        for ((index, assetId) in assetIds.withIndex()) {
            if (isCancelled.get()) throw CancellationException("Scan cancelled")

            // Report progress on main thread
            if (index % 10 == 0) {
                withContext(Dispatchers.Main) {
                    flutterApi.onScanProgress(
                        NativeScanProgress(
                            current = (index + 1).toLong(),
                            total = total
                        )
                    ) {}
                }
            }

            try {
                val metadata = queryAssetMetadata(contentResolver, assetId) ?: continue

                var dHash = ""
                var pHash = ""
                var isBlurry = false
                var hasGPS = false

                // Load thumbnail and compute hash/blur
                if (config.enableHash || config.enableBlurDetection) {
                    val thumbSize = if (config.enableBlurDetection)
                        config.blurThumbnailSize.toInt()
                    else
                        config.thumbnailSize.toInt()

                    val thumbnail = loadThumbnail(contentResolver, metadata.contentUri, thumbSize)
                    if (thumbnail != null) {
                        if (config.enableHash) {
                            // Use smaller thumbnail for hash
                            val hashThumb = if (thumbSize > config.thumbnailSize.toInt()) {
                                Bitmap.createScaledBitmap(
                                    thumbnail,
                                    config.thumbnailSize.toInt(),
                                    config.thumbnailSize.toInt(),
                                    true
                                )
                            } else {
                                thumbnail
                            }
                            dHash = ImageAnalyzer.calculateDHash(hashThumb)
                            pHash = ImageAnalyzer.calculatePHash(hashThumb)
                            if (hashThumb !== thumbnail) hashThumb.recycle()
                        }

                        if (config.enableBlurDetection) {
                            isBlurry = ImageAnalyzer.checkIsBlurry(
                                thumbnail,
                                config.laplacianThreshold,
                                config.motionThreshold
                            )
                        }

                        thumbnail.recycle()
                    }
                }

                // Check GPS
                if (config.enableGPSCheck && metadata.filePath.isNotEmpty()) {
                    hasGPS = ImageAnalyzer.checkHasGPS(metadata.filePath)
                }

                processedAssets.add(
                    AssetData(
                        id = assetId,
                        path = metadata.filePath,
                        width = metadata.width,
                        height = metadata.height,
                        createDateTimeMs = metadata.dateAdded * 1000, // seconds → ms
                        dHash = dHash,
                        pHash = pHash,
                        isBlurry = isBlurry,
                        hasGPS = hasGPS,
                        fileSize = metadata.fileSize
                    )
                )
            } catch (e: Exception) {
                Log.w(TAG, "Error processing asset $assetId: ${e.message}")
                continue
            }
        }

        // Report final progress
        withContext(Dispatchers.Main) {
            flutterApi.onScanProgress(
                NativeScanProgress(current = total, total = total)
            ) {}
        }

        // Phase 2: Clustering (for duplicate detection)
        if (config.enableHash) {
            return clusterAndBuildResults(
                processedAssets,
                config.dHashThreshold.toInt(),
                config.pHashThreshold.toInt()
            )
        }

        // Non-clustering mode: return filtered results
        return processedAssets
            .filter { asset ->
                when {
                    config.enableBlurDetection -> asset.isBlurry
                    config.enableGPSCheck -> asset.hasGPS
                    else -> true
                }
            }
            .map { it.toNativeScanResult() }
    }

    // ===================== MediaStore Queries =====================

    private fun queryAssetMetadata(
        contentResolver: ContentResolver,
        assetId: String
    ): AssetMetadata? {
        // photo_manager uses the MediaStore ID as the asset ID on Android
        val id = assetId.toLongOrNull() ?: return null
        val uri = ContentUris.withAppendedId(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            id
        )

        val projection = arrayOf(
            MediaStore.Images.Media._ID,
            MediaStore.Images.Media.DATA,
            MediaStore.Images.Media.WIDTH,
            MediaStore.Images.Media.HEIGHT,
            MediaStore.Images.Media.DATE_ADDED,
            MediaStore.Images.Media.SIZE
        )

        contentResolver.query(uri, projection, null, null, null)?.use { cursor ->
            if (cursor.moveToFirst()) {
                val path = cursor.getString(
                    cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                ) ?: ""
                val width = cursor.getInt(
                    cursor.getColumnIndexOrThrow(MediaStore.Images.Media.WIDTH)
                )
                val height = cursor.getInt(
                    cursor.getColumnIndexOrThrow(MediaStore.Images.Media.HEIGHT)
                )
                val dateAdded = cursor.getLong(
                    cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATE_ADDED)
                )
                val fileSize = cursor.getLong(
                    cursor.getColumnIndexOrThrow(MediaStore.Images.Media.SIZE)
                )

                return AssetMetadata(
                    contentUri = uri,
                    filePath = path,
                    width = width,
                    height = height,
                    dateAdded = dateAdded,
                    fileSize = fileSize
                )
            }
        }
        return null
    }

    private fun loadThumbnail(
        contentResolver: ContentResolver,
        uri: Uri,
        size: Int
    ): Bitmap? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                contentResolver.loadThumbnail(uri, Size(size, size), null)
            } else {
                // Fallback for API < 29: decode from file with inSampleSize
                val id = ContentUris.parseId(uri)
                @Suppress("DEPRECATION")
                MediaStore.Images.Thumbnails.getThumbnail(
                    contentResolver,
                    id,
                    MediaStore.Images.Thumbnails.MINI_KIND,
                    null
                )
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to load thumbnail for $uri: ${e.message}")
            null
        }
    }

    // ===================== Clustering =====================

    private fun clusterAndBuildResults(
        assets: List<AssetData>,
        dHashThreshold: Int,
        pHashThreshold: Int
    ): List<NativeScanResult> {
        val groups = mutableListOf<MutableList<AssetData>>()

        for (asset in assets) {
            val matchingIndexes = mutableListOf<Int>()

            for (i in groups.indices) {
                if (groups[i].any { member -> areSimilar(asset, member, dHashThreshold, pHashThreshold) }) {
                    matchingIndexes.add(i)
                }
            }

            if (matchingIndexes.isEmpty()) {
                groups.add(mutableListOf(asset))
                continue
            }

            val baseIndex = matchingIndexes.first()
            groups[baseIndex].add(asset)

            // Merge other matching groups into the base group
            for (i in matchingIndexes.size - 1 downTo 1) {
                val mergeIndex = matchingIndexes[i]
                groups[baseIndex].addAll(groups[mergeIndex])
                groups.removeAt(mergeIndex)
            }
        }

        // Only return items that are in duplicate groups (size > 1)
        val results = mutableListOf<NativeScanResult>()
        for (group in groups) {
            if (group.size > 1) {
                val groupId = group[0].id
                for (asset in group) {
                    results.add(asset.toNativeScanResult(groupId = groupId))
                }
            }
        }
        return results
    }

    private fun areSimilar(
        a: AssetData,
        b: AssetData,
        dHashThreshold: Int,
        pHashThreshold: Int
    ): Boolean {
        val d1 = a.dHash
        val d2 = b.dHash
        val p1 = a.pHash
        val p2 = b.pHash

        // Use hash comparison if available (Deep Scan)
        if ((d1.isNotEmpty() && d2.isNotEmpty()) || (p1.isNotEmpty() && p2.isNotEmpty())) {
            val dDist = if (d1.isNotEmpty() && d2.isNotEmpty())
                ImageAnalyzer.hammingDistance(d1, d2) else 99
            val pDist = if (p1.isNotEmpty() && p2.isNotEmpty())
                ImageAnalyzer.hammingDistance(p1, p2) else 99

            if (dDist < 99 && pDist < 99) {
                return dDist <= dHashThreshold && pDist <= pHashThreshold
            }
            // Only one hash → stricter threshold
            return (dDist < 99 && dDist <= 8) || (pDist < 99 && pDist <= 8)
        }

        // Fallback: metadata comparison (Quick Scan)
        val t1 = a.createDateTimeMs / 60000
        val t2 = b.createDateTimeMs / 60000
        return a.width == b.width && a.height == b.height && t1 == t2
    }

    // ===================== Data Classes =====================

    private data class AssetMetadata(
        val contentUri: Uri,
        val filePath: String,
        val width: Int,
        val height: Int,
        val dateAdded: Long, // seconds since epoch
        val fileSize: Long
    )

    private data class AssetData(
        val id: String,
        val path: String,
        val width: Int,
        val height: Int,
        val createDateTimeMs: Long,
        val dHash: String,
        val pHash: String,
        val isBlurry: Boolean,
        val hasGPS: Boolean,
        val fileSize: Long
    ) {
        fun toNativeScanResult(groupId: String? = null) = NativeScanResult(
            id = id,
            path = path,
            width = width.toLong(),
            height = height.toLong(),
            createDateTimeMs = createDateTimeMs,
            dHash = dHash.ifEmpty { null },
            pHash = pHash.ifEmpty { null },
            isBlurry = isBlurry,
            hasGPS = hasGPS,
            groupId = groupId,
            fileSize = fileSize
        )
    }
}
