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

  static Future<List<PhotoItemDb>> _runFastScanInIsolate(
    List<Map<String, dynamic>> assetDataList,
    bool isPro,
  ) {
    return Isolate.run(() => fastScanAlgorithm(assetDataList, isPro));
  }
}

// --- Thuật toán chạy trên Isolate (Top-level functions để tránh capture Isar) ---
List<PhotoItemDb> fastScanAlgorithm(
  List<Map<String, dynamic>> rawAssets,
  bool isPro,
) {
  Map<String, List<Map<String, dynamic>>> groupMap = {};
  List<PhotoItemDb> result = [];

  // Nhóm dựa trên kích thước (W x H) và thời gian (Same Minute)
  for (var asset in rawAssets) {
    int time = asset['createDateTime'] as int;
    int w = asset['width'] as int;
    int h = asset['height'] as int;

    int timeKey = (time / 60000).floor();
    String groupKey = '${w}_${h}_$timeKey';

    if (!groupMap.containsKey(groupKey)) {
      groupMap[groupKey] = [];
    }
    groupMap[groupKey]!.add(asset);
  }

  // Phân loại
  for (var entries in groupMap.values) {
    if (entries.length > 1) {
      // Có khả năng là Duplicate
      for (var i = 0; i < entries.length; i++) {
        final asset = entries[i];
        final type = (i == 0) ? PhotoTypeDb.normal : PhotoTypeDb.duplicate;
        result.add(_createDbItem(asset, type));
      }
    } else {
      // Normal photo -> Kiểm tra độ mờ bằng OpenCV Laplacian Variance (chỉ khi là Pro)
      final asset = entries.first;
      final path = asset['path'] as String?;
      bool isBlurry = false;

      if (isPro && path != null && path.isNotEmpty) {
        try {
          final image = cv.imread(path);
          if (!image.isEmpty) {
            final w = image.width;
            final h = image.height;
            // Resize để tính toán nhanh hơn
            final scale = 300 / (w > h ? w : h);
            final resized = cv.resize(image, (0, 0), fx: scale, fy: scale);

            final gray = cv.cvtColor(resized, cv.COLOR_BGR2GRAY);
            final laplacian = cv.laplacian(gray, cv.MatType.CV_64FC1.value);

            final meanStdDev = cv.meanStdDev(laplacian);
            final variance = meanStdDev.$2.val[0] * meanStdDev.$2.val[0];

            if (variance < 100.0) {
              isBlurry = true;
            }
          }
        } catch (e) {
          debugPrint('OpenCV Error: $e');
        }
      }

      result.add(
        _createDbItem(
          asset,
          isBlurry ? PhotoTypeDb.blurry : PhotoTypeDb.normal,
        ),
      );
    }
  }

  return result;
}

PhotoItemDb _createDbItem(Map<String, dynamic> asset, PhotoTypeDb type) {
  return PhotoItemDb()
    ..localId = asset['id'] as String
    ..path = asset['path'] as String? ?? ''
    ..sizeBytes = asset['sizeBytes'] as int? ?? 0
    ..width = asset['width'] as int
    ..height = asset['height'] as int
    ..createDateTime = asset['createDateTime'] as int
    ..type = type;
}
