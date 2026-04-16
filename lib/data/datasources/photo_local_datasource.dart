import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

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
    final List<Map<String, dynamic>> assetDataList = [];
    // Để tối ưu tốc độ, tạm thời chỉ lấy 200 ảnh mới nhất cho Deep Scan
    final limit = assets.length > 200 ? 200 : assets.length;
    for (var i = 0; i < limit; i++) {
      final e = assets[i];
      final file = await e.file;
      if (file != null) {
        assetDataList.add({
          'id': e.id,
          'width': e.width,
          'height': e.height,
          'createDateTime': e.createDateTime.millisecondsSinceEpoch,
          'path': file.path,
          'sizeBytes': file.lengthSync(),
        });
      }
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
    return result.where((e) => e.isLivePhoto).toList();
  }

  Future<List<AssetEntity>> getBlurryPhotos() async {
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
    final path = asset['path'] as String?;
    String dHash = '';
    String pHash = '';
    bool isBlurry = false;

    if (isPro && path != null && path.isNotEmpty) {
      try {
        final image = cv.imread(path);
        if (!image.isEmpty) {
          isBlurry = _checkIsBlurry(image);
          dHash = _calculateDHash(image);
          pHash = _calculatePHash(image);
          debugPrint(
            'Image: ${path.split('/').last} | dHash: $dHash | pHash: $pHash',
          );
        }
      } catch (e) {
        debugPrint('OpenCV Analysis Error: $e');
      }
    }

    asset['dHash'] = dHash;
    asset['pHash'] = pHash;
    asset['isBlurry'] = isBlurry;
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
      final isBlurry = asset['isBlurry'] as bool? ?? false;

      PhotoTypeDb type;
      if (group.length > 1) {
        // All items in a duplicate group are marked as duplicate,
        // including the first one (the "original")
        type = PhotoTypeDb.duplicate;
      } else if (isBlurry) {
        type = PhotoTypeDb.blurry;
      } else {
        type = PhotoTypeDb.normal;
      }

      result.add(_createDbItem(asset, type, groupId));
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

    // Theo yêu cầu: duplicate if EITHER hash matches
    return dDist <= 10 || pDist <= 10;
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
    final diff = b1 ^ b2;
    // Đếm số lượng bit 1 trong hiệu XOR (Hamming distance)
    return diff.toRadixString(2).split('1').length - 1;
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

  // Thresholds
  const double lapThreshold = 100.0;
  const double motionThreshold = 50.0;

  final isGeneralBlur = lapVariance < lapThreshold;
  final isMotionBlur = (varX - varY).abs() > motionThreshold;

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
    ..sizeBytes = asset['sizeBytes'] as int? ?? 0
    ..width = asset['width'] as int
    ..height = asset['height'] as int
    ..createDateTime = asset['createDateTime'] as int
    ..dHash = asset['dHash'] as String?
    ..pHash = asset['pHash'] as String?
    ..groupId = groupId
    ..type = type;
}
