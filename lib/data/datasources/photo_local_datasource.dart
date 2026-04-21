import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:twinfix/domain/entities/media_item.dart';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/domain/enums/photo_type.dart';

import '../models/photo_item_db.dart';

@lazySingleton
class PhotoLocalDataSource {
  final Isar isar;

  PhotoLocalDataSource({required this.isar});

  /// Fetch all photos from device and group them by duplicate using Isolate
  Future<void> scanAndSavePhotos({bool isPro = false}) async {
    // 1. Fetch from photo_manager (Main Isolate)
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    if (albums.isEmpty) return;

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;

    if (assetCount == 0) return;

    // Fetch all assets
    final List<AssetEntity> assets = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );

    // Chuẩn bị dữ liệu nguyên thủy để truyền vào Isolate
    // Xử lý tuần tự và yield event loop mỗi batch để animation không bị khựng
    final limit = assets.length > 20 ? 20 : assets.length;
    final List<Map<String, dynamic>> assetDataList = [];
    final assetsToProcess = assets.sublist(0, limit);

    for (int i = 0; i < assetsToProcess.length; i++) {
      final e = assetsToProcess[i];

      // Yield event loop mỗi 10 asset để UI animation chạy mượt
      if (i % 10 == 0) {
        await Future.delayed(Duration.zero);
      }

      Uint8List? thumbBytes;
      if (isPro) {
        // Deep Scan: dùng thumbnail để OpenCV đọc nhanh hơn (giảm RAM, tăng tốc I/O)
        thumbBytes = await e.thumbnailDataWithSize(
          const ThumbnailSize.square(64),
        );
      }

      assetDataList.add({
        'id': e.id,
        'width': e.width,
        'height': e.height,
        'createDateTime': e.createDateTime.millisecondsSinceEpoch,
        'thumbBytes': thumbBytes, // Dữ liệu ảnh để phân tích nhanh
      });
    }

    // 2. Chạy thuật toán Fast Scan trên Isolate
    // Chuyển sang top-level function để tránh capture 'this' (chứa Isar)
    final processedList = await _runFastScanInIsolate(assetDataList, isPro);

    // 3. Save to Isar Database
    await isar.writeTxn(() async {
      await isar.photoItemDbs.clear(); // Clear old cache for MVP
      await isar.photoItemDbs.putAll(processedList);
    });
  }

  Future<List<PhotoItemDb>> getAllPhotos() async {
    return await isar.photoItemDbs.where().findAll();
  }

  Future<List<AssetEntity>> getGalleryAssets({
    required RequestType type,
  }) async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: type,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;
    if (assetCount == 0) return [];

    return await recentAlbum.getAssetListRange(start: 0, end: assetCount);
  }

  Future<List<AssetEntity>> getLivePhotoAssets() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;
    if (assetCount == 0) return [];
    final result = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );
    return result.where((e) => e.isLivePhoto).toList();
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

  Future<List<AssetEntity>> getScreenshots() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: true),
        ],
      ),
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;
    if (assetCount == 0) return [];
    final result = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );
    // Filter screenshots by title pattern (iOS/Android naming convention)
    return result.where((e) {
      final title = (e.title ?? '').toLowerCase();
      return title.contains('screenshot') || title.contains('screen shot');
    }).toList();
  }

  Future<List<MediaItem>> getBlurryPhotos() async {
    // 1. Fetch from photo_manager (Main Isolate)
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;

    if (assetCount == 0) return [];

    // Fetch all assets
    final List<AssetEntity> assets = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );

    // Chuẩn bị dữ liệu nguyên thủy để truyền vào Isolate
    // Xử lý tuần tự và yield event loop mỗi batch để animation không bị khựng
    final limit = assets.length > 200 ? 200 : assets.length;
    final List<Map<String, dynamic>> assetDataList = [];
    final assetsToProcess = assets.sublist(0, limit);

    for (int i = 0; i < assetsToProcess.length; i++) {
      final e = assetsToProcess[i];

      // Yield event loop mỗi 10 asset để UI animation chạy mượt
      if (i % 10 == 0) {
        await Future.delayed(Duration.zero);
      }

      final file = await e.file;
      if (file == null) continue;

      // Blur detection: dùng thumbnail cỡ vừa là đủ để detect độ mờ
      final thumbBytes = await e.thumbnailDataWithSize(
        const ThumbnailSize.square(400),
      );

      final sizeBytes = await file.length(); // Async thay vì lengthSync()

      assetDataList.add({
        'id': e.id,
        'width': e.width,
        'height': e.height,
        'createDateTime': e.createDateTime.millisecondsSinceEpoch,
        'path': file.path,
        'thumbBytes': thumbBytes,
        'sizeBytes': sizeBytes,
      });
    }

    // 2. Chạy thuật toán Blur Detection trên Isolate
    final blurryPhotos = await PhotoLocalDataSource._runCheckBlurryInIsolate(
      assetDataList,
    );

    return blurryPhotos;
  }

  Future<List<MediaItem>> getDocuments() async {
    // 1. Fetch from photo_manager
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    if (albums.isEmpty) return [];

    final AssetPathEntity recentAlbum = albums.first;
    final int assetCount = await recentAlbum.assetCountAsync;

    if (assetCount == 0) return [];

    // Fetch assets (limit to 200 for performance, similar to blurry detection)
    final List<AssetEntity> assets = await recentAlbum.getAssetListRange(
      start: 0,
      end: assetCount > 200 ? 200 : assetCount,
    );

    final prefs = await SharedPreferences.getInstance();
    final Set<String> scannedDocsSet =
        (prefs.getStringList('scanned_documents') ?? []).toSet();
    final Set<String> foundDocsSet =
        (prefs.getStringList('found_documents') ?? []).toSet();

    final List<MediaItem> documents = [];
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      for (int i = 0; i < assets.length; i++) {
        final e = assets[i];

        // Yield event loop every 5 assets to keep UI responsive
        if (i % 5 == 0) {
          await Future.delayed(Duration.zero);
        }

        final file = await e.file;
        if (file == null) continue;

        // Check cache first
        if (scannedDocsSet.contains(e.id)) {
          if (foundDocsSet.contains(e.id)) {
            documents.add(
              MediaItem(
                id: e.id,
                path: file.path,
                createDateTime: e.createDateTime,
                assetEntity: e,
                width: e.width,
                height: e.height,
                type: PhotoType.document,
              ),
            );
          }
          continue;
        }

        final inputImage = InputImage.fromFilePath(file.path);
        final RecognizedText recognizedText = await textRecognizer.processImage(
          inputImage,
        );

        scannedDocsSet.add(e.id);

        if (recognizedText.blocks.isNotEmpty) {
          foundDocsSet.add(e.id);
          documents.add(
            MediaItem(
              id: e.id,
              path: file.path,
              createDateTime: e.createDateTime,
              assetEntity: e,
              width: e.width,
              height: e.height,
              type: PhotoType.document,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Text Recognition Error: $e');
    } finally {
      textRecognizer.close();
      await prefs.setStringList('scanned_documents', scannedDocsSet.toList());
      await prefs.setStringList('found_documents', foundDocsSet.toList());
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
          width: asset['width'] as int,
          height: asset['height'] as int,
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
