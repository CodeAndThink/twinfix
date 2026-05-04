class AppConfigs {
  static const String appName = "TwinFix";
  static const String version = "0.1.0";
  static const String buildNumber = "1";

  static const int maxLimitScanPhoto = 200;

  /// Danh sách các mốc kinh nghiệm (số lượng ảnh/video) cần đạt để LÊN level đó.
  /// Index 0: Level 1 (mặc định 0 ảnh)
  /// Index 1: Level 2 (cần 10 ảnh)
  /// Index 2: Level 3 (cần 50 ảnh tổng cộng)
  /// ...
  static const List<double> levelMilestones = [
    0, // Level 1
    10, // Level 2
    50, // Level 3
    150, // Level 4
    350, // Level 5
    700, // Level 6
    1200, // Level 7
    2000, // Level 8
    3500, // Level 9
    5000, // Level 10
  ];

  static const List<int> scanLimitOptions = [50, 100, 200, 300, 500, 0];
}
