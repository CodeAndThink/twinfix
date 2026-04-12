import '../../domain/entities/photo_item.dart';

abstract class PhotoRepository {
  /// Quét nhanh thiết bị (Fast Scan), nhóm các ảnh trùng lặp và lưu vào database
  Future<void> scanAndGroupPhotos({bool isPro = false});

  /// Lấy danh sách ảnh đã được nhóm/phân loại từ Database
  Future<List<PhotoItem>> getGroupedPhotos();
}
