import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/domain/entities/media_item.dart';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:twinfix/domain/enums/photo_type.dart';

import 'package:native_exif/native_exif.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/constants/key_constants.dart';
import 'package:twinfix/data/datasources/native/scanner_native_datasource.dart';
import '../models/photo_item_db.dart';

@lazySingleton
class PhotoLocalDataSource {
  final Isar isar;
  final SharedPreferences _prefs;
  final ScannerNativeDataSource _nativeScanner;
  final List<PhotoItemDb> _cachedPhotos = [];

  PhotoLocalDataSource({
    required this.isar,
    required SharedPreferences prefs,
    required ScannerNativeDataSource nativeScanner,
  }) : _prefs = prefs,
       _nativeScanner = nativeScanner;

  bool _isDocumentScanCancelled = false;

  /// Cancel any running native scan (duplicates, blurry, GPS).
  void cancelScan() {
    _nativeScanner.cancelScan();
  }

  /// Cancel document scan (OCR-based, runs on Dart isolate).
  void cancelDocumentScan() {
    _isDocumentScanCancelled = true;
  }

  /// Clear cached scan results to free memory.
  void clearScanCache() {
    _cachedPhotos.clear();
  }

  int? get _maxLimitScanPhoto {
    final limit =
        _prefs.getInt(KeyConstants.scanLimit) ?? AppConfigs.maxLimitScanPhoto;
    return limit == 0 ? null : limit;
  }

  Future<List<AssetEntity>> _getRecentAssets({
    RequestType type = RequestType.image,
    int? limit,
    FilterOptionGroup? filterOption,
  }) async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: type,
      onlyAll: true,
      filterOption: filterOption,
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;

    if (assetCount == 0) return [];

    final int end = limit != null && assetCount > limit ? limit : assetCount;

    return await recentAlbum.getAssetListRange(start: 0, end: end);
  }

  /// Fetch all photos from device and group them by duplicate.
  /// Uses native background thread via Pigeon — Main Isolate stays free for UI.
  Future<void> scanAndSavePhotos({
    bool isPro = false,
    void Function(int current, int total)? onProgress,
  }) async {
    // 1. Fetch asset list from photo_manager (lightweight, just IDs)
    final assets = await _getRecentAssets();

    if (assets.isEmpty) return;

    final limitValue = _maxLimitScanPhoto ?? assets.length;
    final limit = assets.length > limitValue ? limitValue : assets.length;
    final assetsToProcess = assets.sublist(0, limit);

    // Filter out assets that no longer exist (e.g. moved to "Recently Deleted" or garbage collected)
    final existStatuses = await Future.wait(
      assetsToProcess.map((asset) async {
        try {
          return await asset.exists;
        } catch (_) {
          return false;
        }
      }),
    );

    final List<AssetEntity> validAssets = [];
    for (int i = 0; i < assetsToProcess.length; i++) {
      if (existStatuses[i]) {
        validAssets.add(assetsToProcess[i]);
      }
    }

    if (validAssets.isEmpty) return;

    // 2. Extract IDs — no heavy I/O on Main Isolate
    final assetIds = validAssets.map((e) => e.id).toList();

    // 3. Delegate to native background thread
    final nativeResults = await _nativeScanner.scanForDuplicates(
      assetIds,
      isPro: isPro,
      onProgress: onProgress,
    );

    // 4. Map native results to PhotoItemDb
    final List<PhotoItemDb> allProcessedPhotos = nativeResults.map((r) {
      return PhotoItemDb()
        ..localId = r.id
        ..path = r.path
        ..width = r.width
        ..height = r.height
        ..createDateTime = r.createDateTimeMs
        ..dHash = r.dHash
        ..pHash = r.pHash
        ..groupId = r.groupId
        ..fileSize = r.fileSize ?? 0
        ..type = PhotoTypeDb.duplicate;
    }).toList();

    // 5. Save in memory and clear database cache
    _cachedPhotos.clear();
    _cachedPhotos.addAll(allProcessedPhotos);
    await isar.writeTxn(() => isar.photoItemDbs.clear());
  }

  Future<List<PhotoItemDb>> getAllPhotos() async {
    return List<PhotoItemDb>.from(_cachedPhotos);
  }

  Future<List<MediaItem>> getGalleryAssets({required RequestType type}) async {
    final assets = await _getRecentAssets(
      type: type,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    final List<MediaItem> result = [];
    for (final e in assets) {
      result.add(MediaItemExtension.fromAssetsEntity(e));
    }
    return result;
  }

  Future<List<MediaItem>> getLivePhotoAssets() async {
    final assets = await _getRecentAssets(
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    final List<MediaItem> result = [];
    for (final e in assets) {
      if (e.isLivePhoto) {
        result.add(
          MediaItemExtension.fromAssetsEntity(
            e,
          ).copyWith(type: PhotoType.livePhoto),
        );
      }
    }
    return result;
  }

  Future<List<MediaItem>> getScreenshots() async {
    final assets = await _getRecentAssets(
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    final List<MediaItem> result = [];
    for (final e in assets) {
      final title = (e.title ?? '').toLowerCase();
      if (title.contains('screenshot') || title.contains('screen shot')) {
        result.add(
          MediaItemExtension.fromAssetsEntity(
            e,
          ).copyWith(type: PhotoType.screenshot),
        );
      }
    }
    return result;
  }

  /// Detect blurry photos using native background processing.
  /// Uses Laplacian variance + Sobel directional analysis.
  Future<List<MediaItem>> getBlurryPhotos({
    void Function(int current, int total)? onProgress,
  }) async {
    // 1. Fetch asset list (lightweight)
    final assets = await _getRecentAssets();
    if (assets.isEmpty) return [];

    final limitValue = _maxLimitScanPhoto ?? assets.length;
    final limit = assets.length > limitValue ? limitValue : assets.length;
    final assetsToProcess = assets.sublist(0, limit);

    // 2. Build asset ID list and lookup map (Option B: map AssetEntity after)
    final assetIds = assetsToProcess.map((e) => e.id).toList();
    final assetMap = {for (final e in assetsToProcess) e.id: e};

    // 3. Delegate to native background thread
    final nativeResults = await _nativeScanner.scanForBlurry(
      assetIds,
      onProgress: onProgress,
    );

    // 4. Map results back to MediaItem with AssetEntity (Option B)
    return nativeResults.map((r) {
      final asset = assetMap[r.id];
      return MediaItem(
        id: r.id,
        path: r.path,
        mediaType: MediaType.image,
        createDateTime: DateTime.fromMillisecondsSinceEpoch(r.createDateTimeMs),
        assetEntity: asset,
        width: r.width,
        height: r.height,
        fileSize: r.fileSize ?? 0,
        type: PhotoType.blurry,
      );
    }).toList();
  }

  static void _upscaleWorker(SendPort sendPort) async {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      if (message is Map<String, dynamic>) {
        final String inputPath = message['inputPath'];
        final String outputPath = message['outputPath'];
        final SendPort replyPort = message['replyPort'];

        try {
          final mat = cv.imread(inputPath);
          try {
            if (mat.isEmpty) {
              replyPort.send(null);
              continue;
            }

            // Upscale using linear interpolation
            final scaled = cv.resize(mat, (0, 0), fx: 2.5, fy: 2.5);
            try {
              final (success, encoded) = cv.imencode('.jpg', scaled);

              if (success && encoded.isNotEmpty) {
                final file = File(outputPath);
                await file.writeAsBytes(encoded);
                replyPort.send(outputPath);
              } else {
                replyPort.send(null);
              }
            } finally {
              scaled.dispose();
            }
          } finally {
            mat.dispose();
          }
        } catch (e) {
          debugPrint('Upscale Isolate Error: $e');
          replyPort.send(null);
        }
      }
    }
  }

  Future<List<MediaItem>> getDocuments({
    void Function(int current, int total)? onProgress,
  }) async {
    final assets = await _getRecentAssets(limit: _maxLimitScanPhoto);
    final total = assets.length;

    if (assets.isEmpty) return [];

    final List<MediaItem> documents = [];
    final textRecognizer = TextRecognizer();
    final tempDir = await getTemporaryDirectory();

    // Spawn persistent worker isolate
    final mainReceivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _upscaleWorker,
      mainReceivePort.sendPort,
    );
    final SendPort workerSendPort = await mainReceivePort.first;

    try {
      _isDocumentScanCancelled = false;

      final chunkSize = 4;
      for (int i = 0; i < assets.length; i += chunkSize) {
        if (_isDocumentScanCancelled) break; // Early exit on cancel

        final end = (i + chunkSize < assets.length)
            ? i + chunkSize
            : assets.length;
        final chunk = assets.sublist(i, end);

        final chunkDocuments = await Future.wait(
          chunk.map((e) async {
            try {
              final file = await e.file;
              if (file == null) return null;

              String ocrPath = file.path;
              File? tempOcrFile;

              // --- SCALE UP LOGIC ---
              // If image is small or too thin, scale it up 2.5x to help ML Kit
              if (e.width < 500 || e.height < 500) {
                final tempPath = p.join(tempDir.path, 'ocr_scale_${e.id}.jpg');
                final replyPort = ReceivePort();

                workerSendPort.send({
                  'inputPath': file.path,
                  'outputPath': tempPath,
                  'replyPort': replyPort.sendPort,
                });

                final resultPath = await replyPort.first as String?;
                replyPort.close();

                if (resultPath != null) {
                  ocrPath = resultPath;
                  tempOcrFile = File(resultPath);
                  debugPrint(
                    'Upscaled small image [${e.id}] in background: ${e.width}x${e.height}',
                  );
                }
              }

              final inputImage = InputImage.fromFilePath(ocrPath);
              final RecognizedText recognizedText = await textRecognizer
                  .processImage(inputImage);

              MediaItem? mediaItem;
              if (recognizedText.blocks.isNotEmpty) {
                final fileSize = await file.length();
                mediaItem = MediaItem(
                  id: e.id,
                  path: file.path, // Keep original path
                  mediaType: MediaType.image,
                  createDateTime: e.createDateTime,
                  assetEntity: e,
                  width: e.width,
                  height: e.height,
                  fileSize: fileSize,
                  type: PhotoType.document,
                );
              }

              // Cleanup temp file
              if (tempOcrFile != null && await tempOcrFile.exists()) {
                await tempOcrFile.delete();
              }

              return mediaItem;
            } catch (err) {
              debugPrint('Error processing document for asset ${e.id}: $err');
              return null;
            }
          }),
        );

        documents.addAll(chunkDocuments.whereType<MediaItem>());

        onProgress?.call(end, total);
        await WidgetsBinding.instance.endOfFrame;
      }
    } catch (e) {
      debugPrint('Text Recognition Error: $e');
    } finally {
      isolate.kill(priority: Isolate.immediate);
      mainReceivePort.close();
      textRecognizer.close();
    }

    return documents;
  }

  Future<AssetEntity?> saveImage(Uint8List bytes, {String? title}) async {
    return await PhotoManager.editor.saveImage(
      bytes,
      filename: title ?? 'TwinFix_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<void> deleteAssets(List<String> ids) async {
    await PhotoManager.editor.deleteWithIds(ids);
    // Remove from memory cache immediately so they do not show up
    _cachedPhotos.removeWhere((item) => ids.contains(item.localId));
    await isar.writeTxn(() => isar.photoItemDbs.clear());
  }

  /// Pass 1: Quick scan using latlngAsync on main isolate (platform channel)
  /// Pass 2: EXIF fallback in Isolate using pure Dart `exif` package
  ///
  /// [onProgress] is called with (current, total) to report scan progress.
  /// Uses micro-batching with endOfFrame to keep Lottie animation smooth.
  /// Detect photos with GPS EXIF data using native background processing.
  /// Single-pass native scan replaces the old 2-pass (latlngAsync + EXIF fallback) approach.
  Future<List<MediaItem>> getPhotosWithGPS({
    void Function(int current, int total)? onProgress,
  }) async {
    // 1. Fetch asset list (lightweight)
    final assets = await _getRecentAssets(limit: _maxLimitScanPhoto);
    if (assets.isEmpty) return [];

    // 2. Build asset ID list and lookup map (Option B)
    final assetIds = assets.map((e) => e.id).toList();
    final assetMap = {for (final e in assets) e.id: e};

    // 3. Delegate to native background thread
    final nativeResults = await _nativeScanner.scanForGPS(
      assetIds,
      onProgress: onProgress,
    );

    // 4. Map results back to MediaItem with AssetEntity (Option B)
    return nativeResults.map((r) {
      final asset = assetMap[r.id];
      return MediaItem(
        id: r.id,
        path: r.path,
        mediaType: MediaType.image,
        createDateTime: DateTime.fromMillisecondsSinceEpoch(r.createDateTimeMs),
        assetEntity: asset,
        width: r.width,
        height: r.height,
        fileSize: r.fileSize ?? 0,
        type: PhotoType.normal,
      );
    }).toList();
  }

  Future<void> removeGPS(
    List<String> ids, {
    bool replaceOriginal = false,
  }) async {
    final tempDir = await getTemporaryDirectory();

    for (final id in ids) {
      try {
        final asset = await AssetEntity.fromId(id);
        if (asset == null) continue;

        final file = await asset.originFile;
        if (file == null) continue;

        // 1. Create temporary file
        final tempPath = p.join(
          tempDir.path,
          'tmp_${DateTime.now().microsecondsSinceEpoch}_${p.basename(file.path)}',
        );
        final tempFile = await file.copy(tempPath);

        // 2. Remove GPS using native_exif
        final exif = await Exif.fromPath(tempFile.path);

        // Clearing common GPS tags
        // According to common EXIF standards
        await exif.writeAttributes({
          'GPSLatitude': '',
          'GPSLatitudeRef': '',
          'GPSLongitude': '',
          'GPSLongitudeRef': '',
          'GPSAltitude': '',
          'GPSAltitudeRef': '',
          'GPSTimeStamp': '',
          'GPSDateStamp': '',
          'GPSProcessingMethod': '',
        });

        // 3. Save as new image to gallery
        final bytes = await tempFile.readAsBytes();
        await PhotoManager.editor.saveImage(
          bytes,
          filename: 'TwinFix_NoGPS_${DateTime.now().millisecondsSinceEpoch}',
        );

        // 4. Cleanup
        if (await tempFile.exists()) {
          await tempFile.delete();
        }

        // 5. Delete original if requested
        if (replaceOriginal) {
          await PhotoManager.editor.deleteWithIds([id]);
        }
      } catch (e) {
        debugPrint('Error removing GPS for asset $id: $e');
      }
    }
  }
}
