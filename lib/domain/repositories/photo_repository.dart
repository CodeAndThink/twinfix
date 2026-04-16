import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/domain/entities/media_item.dart';

abstract class PhotoRepository {
  /// Quét nhanh thiết bị (Fast Scan), nhóm các ảnh trùng lặp và lưu vào database
  Future<void> scanAndGroupPhotos({bool isPro = false});

  /// Lấy danh sách ảnh đã được nhóm/phân loại từ Database
  Future<List<MediaItem>> getGroupedPhotos();

  /// Lấy danh sách ảnh Live Photo từ thiết bị
  Future<List<MediaItem>> getLivePhotos();

  /// Lấy danh sách ảnh Live Photo từ thiết bị
  Future<List<MediaItem>> getScreenshots();

  /// Lấy danh sách ảnh Blurry Photo từ thiết bị
  Future<List<MediaItem>> getBlurryPhotos();

  /// Lấy danh sách ảnh từ thiết bị
  Future<List<MediaItem>> getGalleryAssets({required RequestType type});
}
