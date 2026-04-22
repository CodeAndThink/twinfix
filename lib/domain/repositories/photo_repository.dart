import 'dart:typed_data';

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

  /// Lấy danh sách ảnh chứa văn bản (Document) từ thiết bị
  Future<List<MediaItem>> getDocuments();

  /// Lấy danh sách ảnh từ thiết bị
  Future<List<MediaItem>> getGalleryAssets({required RequestType type});

  /// Lấy danh sách ảnh chứa dữ liệu GPS từ thiết bị
  Future<List<MediaItem>> getPhotosWithGPS();

  /// Xóa dữ liệu GPS từ danh sách ảnh
  Future<void> removeGPS(List<String> ids, {bool replaceOriginal = false});

  /// Lưu ảnh vào thư viện
  Future<void> saveImage(Uint8List bytes, {String? title});

  /// Xóa ảnh từ thư viện
  Future<void> deleteAssets(List<String> ids);
}
