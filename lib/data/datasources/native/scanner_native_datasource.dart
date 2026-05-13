import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'scanner_api.g.dart';

/// Dart wrapper for the Pigeon-generated Native Scanner API.
/// Implements ScannerFlutterApi for receiving progress callbacks from native.
///
/// This datasource delegates all heavy image processing to native background
/// threads, keeping the Main Isolate free for UI rendering.
@lazySingleton
class ScannerNativeDataSource implements ScannerFlutterApi {
  ScannerNativeDataSource() {
    // Register this instance to receive progress callbacks from native
    ScannerFlutterApi.setUp(this);
  }

  final ScannerHostApi _hostApi = ScannerHostApi();

  /// Current progress callback (set per-scan, cleared after completion)
  void Function(int current, int total)? _onProgress;

  @override
  void onScanProgress(NativeScanProgress progress) {
    _onProgress?.call(progress.current, progress.total);
  }

  // ==================== Public API ====================

  /// Scan for duplicate photos using dHash + pHash.
  /// Returns only photos that belong to a duplicate group (group size > 1).
  Future<List<NativeScanResult>> scanForDuplicates(
    List<String> assetIds, {
    bool isPro = false,
    void Function(int current, int total)? onProgress,
  }) async {
    _onProgress = onProgress;
    try {
      final results = await _hostApi.scanAssets(
        assetIds,
        NativeScanConfig(
          enableHash: isPro,
          enableBlurDetection: false,
          enableGPSCheck: false,
          thumbnailSize: 64,
          blurThumbnailSize: 400,
          laplacianThreshold: 100.0,
          motionThreshold: 150.0,
          dHashThreshold: 10,
          pHashThreshold: 12,
        ),
      );
      return results;
    } catch (e) {
      debugPrint('Native scanForDuplicates error: $e');
      rethrow;
    } finally {
      _onProgress = null;
    }
  }

  /// Scan for blurry photos using Laplacian variance + Sobel directional analysis.
  /// Returns only photos detected as blurry.
  Future<List<NativeScanResult>> scanForBlurry(
    List<String> assetIds, {
    void Function(int current, int total)? onProgress,
  }) async {
    _onProgress = onProgress;
    try {
      final results = await _hostApi.scanAssets(
        assetIds,
        NativeScanConfig(
          enableHash: false,
          enableBlurDetection: true,
          enableGPSCheck: false,
          thumbnailSize: 64,
          blurThumbnailSize: 400,
          laplacianThreshold: 100.0,
          motionThreshold: 150.0,
          dHashThreshold: 10,
          pHashThreshold: 12,
        ),
      );
      return results;
    } catch (e) {
      debugPrint('Native scanForBlurry error: $e');
      rethrow;
    } finally {
      _onProgress = null;
    }
  }

  /// Scan for photos with GPS EXIF data.
  /// Returns only photos that contain GPS coordinates.
  Future<List<NativeScanResult>> scanForGPS(
    List<String> assetIds, {
    void Function(int current, int total)? onProgress,
  }) async {
    _onProgress = onProgress;
    try {
      final results = await _hostApi.scanAssets(
        assetIds,
        NativeScanConfig(
          enableHash: false,
          enableBlurDetection: false,
          enableGPSCheck: true,
          thumbnailSize: 64,
          blurThumbnailSize: 400,
          laplacianThreshold: 100.0,
          motionThreshold: 150.0,
          dHashThreshold: 10,
          pHashThreshold: 12,
        ),
      );
      return results;
    } catch (e) {
      debugPrint('Native scanForGPS error: $e');
      rethrow;
    } finally {
      _onProgress = null;
    }
  }

  /// Cancel any running scan operation.
  void cancelScan() {
    try {
      _hostApi.cancelScan();
    } catch (e) {
      debugPrint('Native cancelScan error: $e');
    }
  }
}
