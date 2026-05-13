import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/data/datasources/native/scanner_api.g.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com/truongngo/twinfix/scanner/ScannerApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.truongngo.twinfix.scanner'),
  swiftOut: 'ios/Runner/ScannerApi.g.swift',
  dartPackageName: 'twinfix',
))

/// Kết quả scan cho mỗi ảnh
class NativeScanResult {
  NativeScanResult({
    required this.id,
    required this.path,
    required this.width,
    required this.height,
    required this.createDateTimeMs,
    this.dHash,
    this.pHash,
    this.isBlurry = false,
    this.hasGPS = false,
    this.groupId,
    this.fileSize,
  });

  /// Asset ID from photo_manager
  String id;

  /// File path on device
  String path;

  int width;
  int height;

  /// Size in bytes
  int? fileSize;

  /// createDateTime in milliseconds since epoch
  int createDateTimeMs;

  /// Difference Hash (hex string)
  String? dHash;

  /// Perceptual Hash (hex string)
  String? pHash;

  /// Whether the image is blurry
  bool isBlurry;

  /// Whether the image has GPS EXIF data
  bool hasGPS;

  /// Group ID for duplicate clustering
  String? groupId;
}

/// Cấu hình scan — điều khiển tính năng nào được bật
class NativeScanConfig {
  NativeScanConfig({
    this.enableHash = false,
    this.enableBlurDetection = false,
    this.enableGPSCheck = false,
    this.thumbnailSize = 64,
    this.blurThumbnailSize = 400,
    this.laplacianThreshold = 100.0,
    this.motionThreshold = 150.0,
    this.dHashThreshold = 10,
    this.pHashThreshold = 12,
  });

  /// Bật tính toán dHash + pHash cho duplicate detection
  bool enableHash;

  /// Bật blur detection (Laplacian + Sobel)
  bool enableBlurDetection;

  /// Bật GPS EXIF check
  bool enableGPSCheck;

  /// Kích thước thumbnail dùng cho hash (default 64)
  int thumbnailSize;

  /// Kích thước thumbnail dùng cho blur detection (default 400)
  int blurThumbnailSize;

  /// Ngưỡng Laplacian variance cho blur detection
  double laplacianThreshold;

  /// Ngưỡng chênh lệch Sobel X/Y cho motion blur detection
  double motionThreshold;

  /// Ngưỡng Hamming distance cho dHash matching
  int dHashThreshold;

  /// Ngưỡng Hamming distance cho pHash matching
  int pHashThreshold;
}

/// Progress update gửi từ Native → Dart
class NativeScanProgress {
  NativeScanProgress({required this.current, required this.total});

  int current;
  int total;
}

/// Native → Dart: Gửi progress updates real-time
@FlutterApi()
abstract class ScannerFlutterApi {
  void onScanProgress(NativeScanProgress progress);
}

/// Dart → Native: Yêu cầu scan trên background thread
@HostApi()
abstract class ScannerHostApi {
  /// Scan danh sách assets theo config.
  /// Trả về danh sách kết quả đã xử lý (hash, blur, GPS).
  /// Progress được report qua ScannerFlutterApi.onScanProgress.
  @async
  List<NativeScanResult> scanAssets(
    List<String> assetIds,
    NativeScanConfig config,
  );

  /// Huỷ scan đang chạy
  void cancelScan();
}
