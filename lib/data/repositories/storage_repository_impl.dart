import 'package:injectable/injectable.dart';
import '../../domain/entities/storage_info.dart';
import '../../domain/repositories/storage_repository.dart';
import '../datasources/device_storage_datasource.dart';

@LazySingleton(as: StorageRepository)
class StorageRepositoryImpl implements StorageRepository {
  final DeviceStorageDataSource _dataSource;

  StorageRepositoryImpl(this._dataSource);

  @override
  Future<StorageInfo> getStorageSpace() async {
    final space = await _dataSource.getStorageSpace();
    return StorageInfo(
      totalSize: space.total.toDouble(),
      freeSize: space.free.toDouble(),
      usedSize: (space.total - space.free).toDouble(),
      usagePercent: space.usagePercent.toDouble(),
    );
  }
}
