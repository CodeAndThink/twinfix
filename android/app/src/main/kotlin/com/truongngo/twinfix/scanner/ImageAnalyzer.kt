package com.truongngo.twinfix.scanner

import android.graphics.Bitmap
import android.graphics.Color
import kotlin.math.abs
import kotlin.math.cos
import kotlin.math.sqrt

/**
 * Pure Kotlin image analysis algorithms.
 * Port of the Dart/OpenCV algorithms for dHash, pHash, and blur detection.
 * No OpenCV dependency — uses Android Bitmap API directly.
 */
object ImageAnalyzer {

    // ==================== dHash ====================

    /**
     * Calculate Difference Hash (dHash) of a Bitmap.
     * Resizes to 9x8, converts to grayscale, compares adjacent horizontal pixels.
     * Returns 64-bit hash as hex string (16 chars, zero-padded).
     */
    fun calculateDHash(bitmap: Bitmap): String {
        return try {
            // 1. Resize to 9x8 (9 columns needed to compare 8 adjacent pixel pairs)
            val small = Bitmap.createScaledBitmap(bitmap, 9, 8, true)

            // 2. Compare adjacent pixels
            var hash = 0L
            for (y in 0 until 8) {
                for (x in 0 until 8) {
                    val left = getGrayValue(small, x, y)
                    val right = getGrayValue(small, x + 1, y)
                    if (left > right) {
                        hash = hash or (1L shl (y * 8 + x))
                    }
                }
            }

            if (small !== bitmap) small.recycle()
            hash.toULong().toString(16).padStart(16, '0')
        } catch (e: Exception) {
            ""
        }
    }

    // ==================== pHash ====================

    /**
     * Calculate Perceptual Hash (pHash) of a Bitmap.
     * Resizes to 32x32, applies DCT, extracts 8x8 top-left, generates hash from median.
     * Returns 64-bit hash as hex string (16 chars, zero-padded).
     */
    fun calculatePHash(bitmap: Bitmap): String {
        return try {
            // 1. Resize to 32x32
            val small = Bitmap.createScaledBitmap(bitmap, 32, 32, true)

            // 2. Convert to grayscale float array
            val gray = Array(32) { y ->
                DoubleArray(32) { x ->
                    getGrayValue(small, x, y).toDouble()
                }
            }

            if (small !== bitmap) small.recycle()

            // 3. Apply 2D DCT
            val dct = dct2d(gray)

            // 4. Extract 8x8 top-left
            val dctValues = DoubleArray(64)
            for (y in 0 until 8) {
                for (x in 0 until 8) {
                    dctValues[y * 8 + x] = dct[y][x]
                }
            }

            // 5. Calculate median (excluding DC term at [0,0])
            val subValues = dctValues.drop(1).sorted()
            val median = subValues[subValues.size / 2]

            // 6. Generate hash
            var hash = 0L
            for (i in 0 until 64) {
                if (dctValues[i] > median) {
                    hash = hash or (1L shl i)
                }
            }

            hash.toULong().toString(16).padStart(16, '0')
        } catch (e: Exception) {
            ""
        }
    }

    // ==================== Blur Detection ====================

    /**
     * Check if an image is blurry using Laplacian variance + Sobel directional analysis.
     * Port of the Dart _checkIsBlurry function.
     */
    fun checkIsBlurry(
        bitmap: Bitmap,
        laplacianThreshold: Double = 100.0,
        motionThreshold: Double = 150.0
    ): Boolean {
        return try {
            // Resize to standard size for consistent variance calculation
            val w = bitmap.width
            val h = bitmap.height
            val maxDim = maxOf(w, h)
            val targetSize = 500
            val scale = targetSize.toDouble() / maxDim
            val newW = (w * scale).toInt().coerceAtLeast(1)
            val newH = (h * scale).toInt().coerceAtLeast(1)
            val resized = Bitmap.createScaledBitmap(bitmap, newW, newH, true)

            // Convert to grayscale
            val gray = Array(newH) { y ->
                IntArray(newW) { x ->
                    getGrayValue(resized, x, y)
                }
            }

            if (resized !== bitmap) resized.recycle()

            // 1. Laplacian Variance (General Blur)
            val laplacian = applyLaplacian(gray, newW, newH)
            val lapVariance = variance(laplacian)

            // 2. Sobel X and Y (Motion Blur Detection)
            val sobelX = applySobelX(gray, newW, newH)
            val sobelY = applySobelY(gray, newW, newH)
            val varX = variance(sobelX)
            val varY = variance(sobelY)

            val isGeneralBlur = lapVariance < laplacianThreshold
            val isMotionBlur = lapVariance < (laplacianThreshold * 3) &&
                    abs(varX - varY) > motionThreshold

            isGeneralBlur || isMotionBlur
        } catch (e: Exception) {
            false
        }
    }

    // ==================== GPS EXIF Check ====================

    /**
     * Check if an image file has GPS EXIF data.
     * Uses Android's ExifInterface which is more reliable than pure Dart EXIF.
     */
    fun checkHasGPS(filePath: String): Boolean {
        return try {
            val exif = android.media.ExifInterface(filePath)
            val latLong = FloatArray(2)
            if (exif.getLatLong(latLong)) {
                // If both are 0.0, it's likely a missing GPS lock or corrupted EXIF
                if (latLong[0] == 0.0f && latLong[1] == 0.0f) {
                    false
                } else {
                    true
                }
            } else {
                false
            }
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Get latitude and longitude from an image file's EXIF data.
     * Returns a DoubleArray of [latitude, longitude] or null if not found.
     */
    fun getLatLng(filePath: String): DoubleArray? {
        return try {
            val exif = android.media.ExifInterface(filePath)
            val latLong = FloatArray(2)
            if (exif.getLatLong(latLong)) {
                if (latLong[0] == 0.0f && latLong[1] == 0.0f) {
                    null
                } else {
                    doubleArrayOf(latLong[0].toDouble(), latLong[1].toDouble())
                }
            } else {
                null
            }
        } catch (e: Exception) {
            null
        }
    }

    // ==================== Hamming Distance ====================

    fun hammingDistance(h1: String, h2: String): Int {
        if (h1.length != h2.length || h1.isEmpty()) return 99
        return try {
            val b1 = h1.toULong(16)
            val b2 = h2.toULong(16)
            (b1 xor b2).countOneBits()
        } catch (e: Exception) {
            99
        }
    }

    // ==================== Private Helpers ====================

    private fun getGrayValue(bitmap: Bitmap, x: Int, y: Int): Int {
        val pixel = bitmap.getPixel(x, y)
        val r = Color.red(pixel)
        val g = Color.green(pixel)
        val b = Color.blue(pixel)
        // Standard luminance formula
        return (0.299 * r + 0.587 * g + 0.114 * b).toInt()
    }

    /**
     * Simple 2D DCT (Discrete Cosine Transform).
     * Not the fastest but sufficient for 32x32 images.
     */
    private fun dct2d(input: Array<DoubleArray>): Array<DoubleArray> {
        val n = input.size
        val result = Array(n) { DoubleArray(n) }

        // Apply 1D DCT to rows
        val rowDct = Array(n) { DoubleArray(n) }
        for (y in 0 until n) {
            rowDct[y] = dct1d(input[y])
        }

        // Apply 1D DCT to columns
        for (x in 0 until n) {
            val column = DoubleArray(n) { y -> rowDct[y][x] }
            val dctCol = dct1d(column)
            for (y in 0 until n) {
                result[y][x] = dctCol[y]
            }
        }

        return result
    }

    private fun dct1d(input: DoubleArray): DoubleArray {
        val n = input.size
        val result = DoubleArray(n)
        val factor = Math.PI / n

        for (k in 0 until n) {
            var sum = 0.0
            for (i in 0 until n) {
                sum += input[i] * cos(factor * (i + 0.5) * k)
            }
            val alpha = if (k == 0) sqrt(1.0 / n) else sqrt(2.0 / n)
            result[k] = alpha * sum
        }

        return result
    }

    /**
     * Apply 3x3 Laplacian kernel: [0,1,0; 1,-4,1; 0,1,0]
     */
    private fun applyLaplacian(gray: Array<IntArray>, w: Int, h: Int): DoubleArray {
        val result = DoubleArray((w - 2) * (h - 2))
        var idx = 0
        for (y in 1 until h - 1) {
            for (x in 1 until w - 1) {
                val value = -4.0 * gray[y][x] +
                        gray[y - 1][x].toDouble() +
                        gray[y + 1][x].toDouble() +
                        gray[y][x - 1].toDouble() +
                        gray[y][x + 1].toDouble()
                result[idx++] = value
            }
        }
        return result
    }

    /**
     * Apply Sobel X kernel: [-1,0,1; -2,0,2; -1,0,1]
     */
    private fun applySobelX(gray: Array<IntArray>, w: Int, h: Int): DoubleArray {
        val result = DoubleArray((w - 2) * (h - 2))
        var idx = 0
        for (y in 1 until h - 1) {
            for (x in 1 until w - 1) {
                val value = (-1.0 * gray[y - 1][x - 1] + gray[y - 1][x + 1] +
                        -2.0 * gray[y][x - 1] + 2.0 * gray[y][x + 1] +
                        -1.0 * gray[y + 1][x - 1] + gray[y + 1][x + 1])
                result[idx++] = value
            }
        }
        return result
    }

    /**
     * Apply Sobel Y kernel: [-1,-2,-1; 0,0,0; 1,2,1]
     */
    private fun applySobelY(gray: Array<IntArray>, w: Int, h: Int): DoubleArray {
        val result = DoubleArray((w - 2) * (h - 2))
        var idx = 0
        for (y in 1 until h - 1) {
            for (x in 1 until w - 1) {
                val value = (-1.0 * gray[y - 1][x - 1] - 2.0 * gray[y - 1][x] - gray[y - 1][x + 1] +
                        gray[y + 1][x - 1] + 2.0 * gray[y + 1][x] + gray[y + 1][x + 1])
                result[idx++] = value
            }
        }
        return result
    }

    /**
     * Calculate variance of a double array (population variance).
     * Uses stddev^2 like the Dart version (meanStdDev.$2.val[0] ^ 2).
     */
    private fun variance(data: DoubleArray): Double {
        if (data.isEmpty()) return 0.0
        val mean = data.average()
        var sumSq = 0.0
        for (v in data) {
            val diff = v - mean
            sumSq += diff * diff
        }
        val stdDev = sqrt(sumSq / data.size)
        return stdDev * stdDev // variance = stddev^2
    }
}
