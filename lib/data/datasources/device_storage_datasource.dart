import 'package:injectable/injectable.dart';
import 'package:storage_space/storage_space.dart' as ss;

@lazySingleton
class DeviceStorageDataSource {
  Future<ss.StorageSpace> getStorageSpace() async {
    return await ss.getStorageSpace(
      lowOnSpaceThreshold: 2 * 1024 * 1024 * 1024, // 2GB
      fractionDigits: 1,
    );
  }
}
