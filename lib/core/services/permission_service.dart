import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';

@lazySingleton
class PermissionService {
  /// Request photo library permission using photo_manager
  /// Returns true if permission is granted or limited, false otherwise.
  Future<bool> requestPhotoPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    // For iOS 14+, 'limited' is also considered a success since we can scan the allowed photos.
    if (ps.isAuth || ps.hasAccess) {
      return true;
    }

    // If not granted, we might want to prompt the user to open settings.
    return false;
  }

  /// Check current permission status
  Future<PermissionState> checkPermissionStatus() async {
    return await PhotoManager.requestPermissionExtend();
  }

  /// Open app settings
  void openAppSettings() {
    PhotoManager.openSetting();
  }
}
