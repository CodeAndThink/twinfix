import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
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
  Future<void> scanAndGroupPhotos({bool isPro = false}) async {
    await localDataSource.scanAndSavePhotos(isPro: isPro);
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
        dHash: db.dHash,
        pHash: db.pHash,
        groupId: db.groupId,
      );
    }).toList();
  }

  @override
  Future<List<MediaItem>> getLivePhotos() async {
    final result = await localDataSource.getLivePhotoAssets();
    return result.map((e) => MediaItemExtension.fromAssetsEntity(e)).toList();
  }

  @override
  Future<List<MediaItem>> getGalleryAssets({required RequestType type}) async {
    final result = await localDataSource.getGalleryAssets(type: type);
    return result.map((e) => MediaItemExtension.fromAssetsEntity(e)).toList();
  }

  @override
  Future<List<MediaItem>> getScreenshots() async {
    final result = await localDataSource.getScreenshots();
    return result.map((e) => MediaItemExtension.fromAssetsEntity(e)).toList();
  }

  @override
  Future<List<MediaItem>> getBlurryPhotos() async {
    return await localDataSource.getBlurryPhotos();
  }

  @override
  Future<void> saveImage(Uint8List bytes, {String? title}) async {
    await localDataSource.saveImage(bytes, title: title);
  }

  @override
  Future<void> deleteAssets(List<String> ids) async {
    await localDataSource.deleteAssets(ids);
  }
}
