import '../entities/storage_info.dart';

abstract class StorageRepository {
  Future<StorageInfo> getStorageSpace();
}
