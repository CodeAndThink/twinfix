import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/utils/datetime_utils.dart';

import '../../domain/entities/media_item.dart';
import '../../domain/enums/photo_type.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasources/photo_local_datasource.dart';
import '../models/photo_item_db.dart';

@LazySingleton(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoLocalDataSource localDataSource;

  PhotoRepositoryImpl({required this.localDataSource});

  @override
  Future<void> scanAndGroupPhotos({
    bool isPro = false,
    void Function(int current, int total)? onProgress,
  }) async {
    await localDataSource.scanAndSavePhotos(
      isPro: isPro,
      onProgress: onProgress,
    );
  }

  @override
  Future<List<MediaItem>> getGroupedPhotos() async {
    final dbs = await localDataSource.getAllPhotos();

    // Mapper from DB to Entity
    return dbs.map((db) {
      PhotoType type;
      switch (db.type) {
        case PhotoTypeDb.normal:
          type = PhotoType.normal;
          break;
        case PhotoTypeDb.duplicate:
          type = PhotoType.duplicate;
          break;
        case PhotoTypeDb.burst:
          type = PhotoType.burst;
          break;
        case PhotoTypeDb.blurry:
          type = PhotoType.blurry;
          break;
        case PhotoTypeDb.screenshot:
          type = PhotoType.screenshot;
          break;
      }

      return MediaItem(
        id: db.localId,
        path: db.path,
        createDateTime: DatetimeUtils.fromMillisecondsSinceEpoch(
          millisecondsSinceEpoch: db.createDateTime,
        ),
        assetEntity: AssetEntity(
          id: db.localId,
          typeInt: 1,
          width: db.width,
          height: db.height,
        ),
        width: db.width,
        height: db.height,
        type: type,
        mediaType: MediaType.image,
        dHash: db.dHash,
        pHash: db.pHash,
        groupId: db.groupId,
      );
    }).toList();
  }

  @override
  Future<List<MediaItem>> getLivePhotos() async {
    return await localDataSource.getLivePhotoAssets();
  }

  @override
  Future<List<MediaItem>> getGalleryAssets({required RequestType type}) async {
    return await localDataSource.getGalleryAssets(type: type);
  }

  @override
  Future<List<MediaItem>> getScreenshots() async {
    return await localDataSource.getScreenshots();
  }

  @override
  Future<List<MediaItem>> getBlurryPhotos({
    void Function(int current, int total)? onProgress,
  }) async {
    return await localDataSource.getBlurryPhotos(onProgress: onProgress);
  }

  @override
  Future<List<MediaItem>> getDocuments({
    void Function(int current, int total)? onProgress,
  }) async {
    return await localDataSource.getDocuments(onProgress: onProgress);
  }

  @override
  Future<List<MediaItem>> getPhotosWithGPS({
    void Function(int current, int total)? onProgress,
  }) async {
    return await localDataSource.getPhotosWithGPS(onProgress: onProgress);
  }

  @override
  Future<void> removeGPS(
    List<String> ids, {
    bool replaceOriginal = false,
  }) async {
    await localDataSource.removeGPS(ids, replaceOriginal: replaceOriginal);
  }

  @override
  Future<void> saveImage(Uint8List bytes, {String? title}) async {
    await localDataSource.saveImage(bytes, title: title);
  }

  @override
  Future<void> deleteAssets(List<String> ids) async {
    await localDataSource.deleteAssets(ids);
  }

  @override
  void cancelScan() {
    localDataSource.cancelScan();
  }

  @override
  void cancelDocumentScan() {
    localDataSource.cancelDocumentScan();
  }

  @override
  void clearScanCache() {
    localDataSource.clearScanCache();
  }
}
