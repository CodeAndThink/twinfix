import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:exif/exif.dart' as dart_exif;
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

  PhotoLocalDataSource({
    required this.isar,
    required SharedPreferences prefs,
    required ScannerNativeDataSource nativeScanner,
  }) : _prefs = prefs,
       _nativeScanner = nativeScanner;

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

    // 2. Extract IDs — no heavy I/O on Main Isolate
    final assetIds = assetsToProcess.map((e) => e.id).toList();

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
        ..type = PhotoTypeDb.duplicate;
    }).toList();

    // 5. Save to Isar Database
    await isar.writeTxn(() async {
      await isar.photoItemDbs.clear(); // Clear old cache for MVP
      await isar.photoItemDbs.putAll(allProcessedPhotos);
    });
  }

  Future<List<PhotoItemDb>> getAllPhotos() async {
    return await isar.photoItemDbs.where().findAll();
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

  static Future<List<PhotoItemDb>> _runFastScanInIsolate(
    List<Map<String, dynamic>> assetDataList,
    bool isPro,
  ) {
    return Isolate.run(() => _fastScanAlgorithm(assetDataList, isPro));
  }

  static Future<List<MediaItem>> _runCheckBlurryInIsolate(
    List<Map<String, dynamic>> assetDataList,
  ) {
    return Isolate.run(() => _blurryAlgorithm(assetDataList));
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
        type: PhotoType.blurry,
      );
    }).toList();
  }

  static Future<String?> _upscaleImageForOcr(
    Map<String, dynamic> params,
  ) async {
    final String inputPath = params['inputPath'];
    final String outputPath = params['outputPath'];
    try {
      final mat = cv.imread(inputPath);
      if (mat.isEmpty) return null;

      // Upscale using linear interpolation
      final scaled = cv.resize(mat, (0, 0), fx: 2.5, fy: 2.5);
      final (success, encoded) = cv.imencode('.jpg', scaled);

      if (success && encoded.isNotEmpty) {
        final file = File(outputPath);
        await file.writeAsBytes(encoded);
        mat.dispose();
        scaled.dispose();
        return outputPath;
      }
      mat.dispose();
      scaled.dispose();
    } catch (e) {
      debugPrint('Upscale Isolate Error: $e');
    }
    return null;
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

    try {
      for (int i = 0; i < assets.length; i++) {
        final e = assets[i];

        // Yield event loop every 5 assets to keep UI responsive
        if (i % 5 == 0) {
          await WidgetsBinding.instance.endOfFrame;
        }

        onProgress?.call(i + 1, total);

        try {
          final file = await e.file;
          if (file == null) continue;

          String ocrPath = file.path;
          File? tempOcrFile;

          // --- SCALE UP LOGIC ---
          // If image is small or too thin (e.g., banner/graph), scale it up 2.5x to help ML Kit
          if (e.width < 500 || e.height < 500) {
            final tempPath = p.join(tempDir.path, 'ocr_scale_${e.id}.jpg');
            final resultPath = await Isolate.run(
              () => _upscaleImageForOcr({
                'inputPath': file.path,
                'outputPath': tempPath,
              }),
            );

            if (resultPath != null) {
              ocrPath = resultPath;
              tempOcrFile = File(resultPath);
              debugPrint(
                'Upscaled small image [${e.id}] in background for better OCR: ${e.width}x${e.height}',
              );
            }
          }

          final inputImage = InputImage.fromFilePath(ocrPath);
          final RecognizedText recognizedText = await textRecognizer
              .processImage(inputImage);

          if (recognizedText.blocks.isNotEmpty) {
            documents.add(
              MediaItem(
                id: e.id,
                path: file.path, // Keep original path
                mediaType: MediaType.image,
                createDateTime: e.createDateTime,
                assetEntity: e,
                width: e.width,
                height: e.height,
                type: PhotoType.document,
              ),
            );
          }

          // Cleanup temporary file immediately
          if (tempOcrFile != null && await tempOcrFile.exists()) {
            await tempOcrFile.delete();
          }
        } catch (err) {
          debugPrint('Error processing document for asset ${e.id}: $err');
          continue;
        }
      }
    } catch (e) {
      debugPrint('Text Recognition Error: $e');
    } finally {
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

// --- Thuật toán chạy trên Isolate (Top-level functions để tránh capture Isar) ---
List<PhotoItemDb> _fastScanAlgorithm(
  List<Map<String, dynamic>> rawAssets,
  bool isPro,
) {
  List<PhotoItemDb> result = [];
  List<Map<String, dynamic>> processedAssets = [];

  // 1. Phân tích từng ảnh (Hash, Blurry)
  for (var asset in rawAssets) {
    final thumbBytes = asset['thumbBytes'] as Uint8List?;
    final path = asset['path'] as String?;

    String dHash = '';
    String pHash = '';
    if (isPro) {
      try {
        cv.Mat image;
        if (thumbBytes != null && thumbBytes.isNotEmpty) {
          image = cv.imdecode(thumbBytes, cv.IMREAD_COLOR);
        } else if (path != null && path.isNotEmpty) {
          image = cv.imread(path);
        } else {
          continue;
        }

        if (!image.isEmpty) {
          dHash = _calculateDHash(image);
          pHash = _calculatePHash(image);
          image.dispose();
          debugPrint(
            'Image: ${path?.split('/').last} | dHash: $dHash | pHash: $pHash',
          );
        }
      } catch (e) {
        debugPrint('OpenCV Analysis Error: $e');
      }
    }

    asset['dHash'] = dHash;
    asset['pHash'] = pHash;
    processedAssets.add(asset);
  }

  // 2. Gom nhóm dựa trên độ tương đồng (Clustering)
  final groups = _clusterSimilarAssets(processedAssets);

  // 3. Chuyển đổi sang Model DB
  for (var group in groups) {
    // Generate a unique ID for this group, e.g., the localId of the first item
    final groupId = group.isNotEmpty ? group[0]['id'] as String : '';

    for (int i = 0; i < group.length; i++) {
      final asset = group[i];

      PhotoTypeDb type;
      if (group.length > 1) {
        // All items in a duplicate group are marked as duplicate,
        // including the first one (the "original")
        type = PhotoTypeDb.duplicate;
        result.add(_createDbItem(asset, type, groupId));
      }
    }
  }

  return result;
}

// --- Thuật toán chạy trên Isolate (Top-level functions để tránh capture Isar) ---
List<MediaItem> _blurryAlgorithm(List<Map<String, dynamic>> rawAssets) {
  List<MediaItem> result = [];

  for (var asset in rawAssets) {
    final thumbBytes = asset['thumbBytes'] as Uint8List?;
    final path = asset['path'] as String?;
    bool isBlurry = false;

    try {
      cv.Mat image;
      if (thumbBytes != null && thumbBytes.isNotEmpty) {
        image = cv.imdecode(thumbBytes, cv.IMREAD_COLOR);
      } else if (path != null && path.isNotEmpty) {
        image = cv.imread(path);
      } else {
        continue;
      }

      if (!image.isEmpty) {
        isBlurry = _checkIsBlurry(image);
        image.dispose();
      }
    } catch (e) {
      debugPrint('OpenCV Analysis Error: $e');
    }

    if (isBlurry) {
      result.add(
        MediaItem(
          id: asset['id'] as String,
          path: asset['path'] as String,
          createDateTime: DateTime.fromMillisecondsSinceEpoch(
            asset['createDateTime'] as int,
          ),
          assetEntity: asset['assetEntity'] as AssetEntity,
          width: asset['width'] as int,
          height: asset['height'] as int,
          type: PhotoType.blurry,
        ),
      );
    }
  }

  return result;
}

List<List<Map<String, dynamic>>> _clusterSimilarAssets(
  List<Map<String, dynamic>> assets,
) {
  final List<List<Map<String, dynamic>>> groups = [];

  for (final asset in assets) {
    final matchingIndexes = <int>[];

    for (int i = 0; i < groups.length; i++) {
      if (groups[i].any((member) => _areSimilar(asset, member))) {
        matchingIndexes.add(i);
      }
    }

    if (matchingIndexes.isEmpty) {
      groups.add([asset]);
      continue;
    }

    final baseIndex = matchingIndexes.first;
    groups[baseIndex].add(asset);

    for (int i = matchingIndexes.length - 1; i >= 1; i--) {
      final mergeIndex = matchingIndexes[i];
      groups[baseIndex].addAll(groups[mergeIndex]);
      groups.removeAt(mergeIndex);
    }
  }

  return groups;
}

bool _areSimilar(Map<String, dynamic> a, Map<String, dynamic> b) {
  final d1 = a['dHash'] as String? ?? '';
  final d2 = b['dHash'] as String? ?? '';
  final p1 = a['pHash'] as String? ?? '';
  final p2 = b['pHash'] as String? ?? '';

  // Ưu tiên dùng Hash để so sánh (Deep Scan)
  if ((d1.isNotEmpty && d2.isNotEmpty) || (p1.isNotEmpty && p2.isNotEmpty)) {
    int dDist = d1.isNotEmpty && d2.isNotEmpty ? _hammingDistance(d1, d2) : 99;
    int pDist = p1.isNotEmpty && p2.isNotEmpty ? _hammingDistance(p1, p2) : 99;

    // Kết hợp cả hai hash để giảm false positive:
    // - Nếu cả hai hash đều có: cả hai phải match
    // - Nếu chỉ có một hash: dùng threshold chặt hơn
    if (dDist < 99 && pDist < 99) {
      return dDist <= 10 && pDist <= 12;
    }
    // Chỉ có một hash → dùng threshold chặt hơn
    return (dDist < 99 && dDist <= 8) || (pDist < 99 && pDist <= 8);
  }

  // Fallback dùng Metadata (Quick Scan)
  final w1 = a['width'] as int;
  final h1Metadata = a['height'] as int;
  final t1 = ((a['createDateTime'] as int) / 60000).floor();

  final w2 = b['width'] as int;
  final h2Metadata = b['height'] as int;
  final t2 = ((b['createDateTime'] as int) / 60000).floor();

  return w1 == w2 && h1Metadata == h2Metadata && t1 == t2;
}

int _hammingDistance(String h1, String h2) {
  if (h1.length != h2.length) return 99;
  try {
    final b1 = BigInt.parse(h1, radix: 16);
    final b2 = BigInt.parse(h2, radix: 16);
    var diff = b1 ^ b2;
    // Brian Kernighan's popcount — hiệu quả hơn string conversion
    int count = 0;
    while (diff > BigInt.zero) {
      diff &= (diff - BigInt.one);
      count++;
    }
    return count;
  } catch (e) {
    return 99;
  }
}

bool _checkIsBlurry(cv.Mat image) {
  final w = image.width;
  final h = image.height;
  // Resize to a standard size for consistent variance calculation
  final scale = 500 / (w > h ? w : h);
  final resized = cv.resize(image, (0, 0), fx: scale, fy: scale);
  final gray = cv.cvtColor(resized, cv.COLOR_BGR2GRAY);

  // 1. Laplacian Variance (General Blur)
  final laplacian = cv.laplacian(gray, cv.MatType.CV_64FC1.value);
  final lapMeanStdDev = cv.meanStdDev(laplacian);
  final lapVariance = lapMeanStdDev.$2.val[0] * lapMeanStdDev.$2.val[0];

  // 2. Sobel X and Y (Motion Blur Detection)
  // Sobel X detects vertical edges, Sobel Y detects horizontal edges
  final sobelX = cv.sobel(gray, cv.MatType.CV_64FC1.value, 1, 0);
  final sobelY = cv.sobel(gray, cv.MatType.CV_64FC1.value, 0, 1);

  final xMeanStdDev = cv.meanStdDev(sobelX);
  final yMeanStdDev = cv.meanStdDev(sobelY);

  final varX = xMeanStdDev.$2.val[0] * xMeanStdDev.$2.val[0];
  final varY = yMeanStdDev.$2.val[0] * yMeanStdDev.$2.val[0];

  // Dispose OpenCV Mats to prevent memory leaks
  resized.dispose();
  gray.dispose();
  laplacian.dispose();
  sobelX.dispose();
  sobelY.dispose();

  // Thresholds
  const double lapThreshold = 100.0;
  // Motion blur threshold cao hơn để tránh false positive trên ảnh có texture
  // theo một hướng (hàng rào, tòa nhà, v.v.)
  const double motionThreshold = 150.0;

  final isGeneralBlur = lapVariance < lapThreshold;
  // Motion blur chỉ tính khi ảnh đã có dấu hiệu mờ (lapVariance thấp)
  // Tránh false positive trên ảnh sắc nét nhưng có texture một hướng
  final isMotionBlur =
      lapVariance < (lapThreshold * 3) && (varX - varY).abs() > motionThreshold;

  debugPrint(
    'Blur Analysis | LapVar: ${lapVariance.toStringAsFixed(2)} | VarX: ${varX.toStringAsFixed(2)} | VarY: ${varY.toStringAsFixed(2)}',
  );

  return isGeneralBlur || isMotionBlur;
}

String _calculateDHash(cv.Mat image) {
  try {
    // 1. Resize to 9x8 (Cần 9 cột để so sánh 8 cặp điểm ảnh liền kề)
    final small = cv.resize(image, (9, 8));
    // 2. Chuyển sang ảnh xám
    final gray = cv.cvtColor(small, cv.COLOR_BGR2GRAY);
    // 3. So sánh các điểm ảnh liền kề theo hàng ngang
    final bytes = gray.data;
    BigInt hash = BigInt.zero;
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        // So sánh điểm ảnh x với điểm ảnh x + 1
        final left = bytes[y * 9 + x];
        final right = bytes[y * 9 + x + 1];
        if (left > right) {
          hash |= (BigInt.one << (y * 8 + x));
        }
      }
    }
    // Dispose intermediate Mats
    small.dispose();
    gray.dispose();
    return hash.toRadixString(16).padLeft(16, '0');
  } catch (e) {
    return '';
  }
}

String _calculatePHash(cv.Mat image) {
  try {
    // 1. Resize to 32x32
    final small = cv.resize(image, (32, 32));
    // 2. Grayscale
    final gray = cv.cvtColor(small, cv.COLOR_BGR2GRAY);
    // 3. Convert to 32-bit float for DCT
    final floatGray = gray.convertTo(cv.MatType.CV_32FC1);
    // 4. DCT
    final dct = cv.dct(floatGray);
    // 5. Extract 8x8 top-left
    // We convert the DCT matrix to a 2D list for easier access in Dart
    final dctList = dct.toList();
    List<double> dctValues = [];
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        dctValues.add(dctList[y][x] as double);
      }
    }

    // Dispose intermediate Mats
    small.dispose();
    gray.dispose();
    floatGray.dispose();
    dct.dispose();

    // 6. Calculate median (excluding DC term at [0,0])
    final subValues = dctValues.sublist(1);
    subValues.sort();
    double median = subValues[subValues.length ~/ 2];

    // 7. Generate hash
    BigInt hash = BigInt.zero;
    for (int i = 0; i < 64; i++) {
      if (dctValues[i] > median) {
        hash |= (BigInt.one << i);
      }
    }
    return hash.toRadixString(16).padLeft(16, '0');
  } catch (e) {
    debugPrint('pHash Error: $e');
    return '';
  }
}

PhotoItemDb _createDbItem(
  Map<String, dynamic> asset,
  PhotoTypeDb type,
  String groupId,
) {
  return PhotoItemDb()
    ..localId = asset['id'] as String
    ..path = asset['path'] as String? ?? ''
    ..width = asset['width'] as int
    ..height = asset['height'] as int
    ..createDateTime = asset['createDateTime'] as int
    ..dHash = asset['dHash'] as String?
    ..pHash = asset['pHash'] as String?
    ..groupId = groupId
    ..type = type;
}

/// Top-level function for Isolate: Check GPS via pure Dart EXIF reader.
/// Reads file bytes and parses EXIF — no platform channels needed.
Future<List<Map<String, dynamic>>> _checkGPSViaExif(
  List<Map<String, dynamic>> assets,
) async {
  final List<Map<String, dynamic>> results = [];

  for (final asset in assets) {
    try {
      final path = asset['path'] as String;
      final fileBytes = File(path).readAsBytesSync();
      final data = await dart_exif.readExifFromBytes(fileBytes);

      // Check for GPS latitude tag
      if (data.containsKey('GPS GPSLatitude')) {
        results.add(asset);
      }
    } catch (_) {
      // Skip files that can't be read or parsed
    }
  }

  return results;
}
