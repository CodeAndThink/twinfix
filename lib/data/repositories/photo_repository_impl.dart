import 'package:injectable/injectable.dart';

import '../../domain/entities/photo_item.dart';
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
  Future<List<PhotoItem>> getGroupedPhotos() async {
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

      return PhotoItem(
        id: db.localId,
        path: db.path,
        sizeBytes: db.sizeBytes,
        createDateTime: db.createDateTime,
        width: db.width,
        height: db.height,
        type: type,
      );
    }).toList();
  }
}
