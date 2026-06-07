import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/domain/entities/media_item.dart';

abstract class PhotoRepository {
  /// Fast Scan the device, group duplicate photos, and save to the database
  Future<void> scanAndGroupPhotos({
    bool isPro = false,
    void Function(int current, int total)? onProgress,
  });

  /// Get the list of grouped/categorized photos from the Database
  Future<List<MediaItem>> getGroupedPhotos();

  /// Get the list of Live Photos from the device
  Future<List<MediaItem>> getLivePhotos();

  /// Get the list of Screenshots from the device
  Future<List<MediaItem>> getScreenshots();

  /// Get the list of Blurry Photos from the device
  Future<List<MediaItem>> getBlurryPhotos({
    void Function(int current, int total)? onProgress,
  });

  /// Get the list of text-containing photos (Documents) from the device
  Future<List<MediaItem>> getDocuments({
    void Function(int current, int total)? onProgress,
  });

  /// Get the list of photos from the device
  Future<List<MediaItem>> getGalleryAssets({required RequestType type});

  /// Get the list of photos containing GPS data from the device
  Future<List<MediaItem>> getPhotosWithGPS({
    void Function(int current, int total)? onProgress,
  });

  /// Delete GPS data from a list of photos
  Future<void> removeGPS(List<String> ids, {bool replaceOriginal = false});

  /// Save photo to the gallery
  Future<void> saveImage(Uint8List bytes, {String? title});

  /// Delete photos from the gallery
  Future<void> deleteAssets(List<String> ids);

  /// Cancel any running native scan (duplicates, blurry, GPS).
  void cancelScan();

  /// Cancel document scan (OCR-based).
  void cancelDocumentScan();

  /// Clear cached scan results to free memory.
  void clearScanCache();
}
