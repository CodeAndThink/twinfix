import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/data/datasources/native/scanner_api.g.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com/truongngo/twinfix/scanner/ScannerApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.truongngo.twinfix.scanner'),
  swiftOut: 'ios/Runner/ScannerApi.g.swift',
  dartPackageName: 'twinfix',
))

/// Scan result for each image
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

/// Scan configuration — controls which features are enabled
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

  /// Enable dHash + pHash computation for duplicate detection
  bool enableHash;

  /// Enable blur detection (Laplacian + Sobel)
  bool enableBlurDetection;

  /// Enable GPS EXIF check
  bool enableGPSCheck;

  /// Thumbnail size used for hashing (default 64)
  int thumbnailSize;

  /// Thumbnail size used for blur detection (default 400)
  int blurThumbnailSize;

  /// Laplacian variance threshold for blur detection
  double laplacianThreshold;

  /// Sobel X/Y difference threshold for motion blur detection
  double motionThreshold;

  /// Hamming distance threshold for dHash matching
  int dHashThreshold;

  /// Hamming distance threshold for pHash matching
  int pHashThreshold;
}

/// Progress update sent from Native → Dart
class NativeScanProgress {
  NativeScanProgress({required this.current, required this.total});

  int current;
  int total;
}

/// Native → Dart: Send real-time progress updates
@FlutterApi()
abstract class ScannerFlutterApi {
  void onScanProgress(NativeScanProgress progress);
}

/// Dart → Native: Request scan on a background thread
@HostApi()
abstract class ScannerHostApi {
  /// Scan the list of assets according to the config.
  /// Returns the list of processed results (hash, blur, GPS).
  /// Progress is reported via ScannerFlutterApi.onScanProgress.
  @async
  List<NativeScanResult> scanAssets(
    List<String> assetIds,
    NativeScanConfig config,
  );

  /// Cancel the currently running scan
  void cancelScan();
}
