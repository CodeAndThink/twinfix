class AppConfigs {
  /// Danh sách các mốc kinh nghiệm (bytes) cần đạt để LÊN level đó.
  /// Index 0: Level 1 (mặc định 0 bytes)
  /// Index 1: Level 2 (cần 100MB)
  /// Index 2: Level 3 (cần 300MB tổng cộng)
  /// ...
  static const List<double> levelMilestones = [
    0, // Level 1
    10 * 1024 * 1024, // Level 2: 10 MB
    20 * 1024 * 1024, // Level 3: 20 MB
    50 * 1024 * 1024, // Level 4: 50 MB
    100 * 1024 * 1024, // Level 5: 100 MB
    200 * 1024 * 1024, // Level 6: 200 MB
    500 * 1024 * 1024, // Level 7: 500 MB
    1.0 * 1024 * 1024 * 1024, // Level 8: 1.0 GB
    2.0 * 1024 * 1024 * 1024, // Level 9: 2.0 GB
    5.0 * 1024 * 1024 * 1024, // Level 10: 5.0 GB
  ];

  /// Tính toán Level hiện tại dựa trên tổng số bytes đã dọn dẹp
  static int getLevelFromBytes(int totalBytes) {
    for (int i = levelMilestones.length - 1; i >= 0; i--) {
      if (totalBytes >= levelMilestones[i]) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Tính toán % tiến trình của Level hiện tại (từ 0.0 đến 1.0)
  static double getLevelProgress(int totalBytes) {
    final currentLevel = getLevelFromBytes(totalBytes);

    // Nếu đã đạt level tối đa trong config
    if (currentLevel >= levelMilestones.length) {
      return 1.0;
    }

    final currentMilestone = levelMilestones[currentLevel - 1];
    final nextMilestone = levelMilestones[currentLevel];

    final progress =
        (totalBytes - currentMilestone) / (nextMilestone - currentMilestone);
    return progress.clamp(0.0, 1.0);
  }

  /// Lấy số bytes cần dọn dẹp thêm để lên level kế tiếp
  static double getBytesToNextLevel(int totalBytes) {
    final currentLevel = getLevelFromBytes(totalBytes);
    if (currentLevel >= levelMilestones.length) return 0;

    return levelMilestones[currentLevel] - totalBytes;
  }

  /// Lấy mốc kinh nghiệm (bytes) của level kế tiếp
  static double getNextMilestone(int totalBytes) {
    final currentLevel = getLevelFromBytes(totalBytes);
    if (currentLevel >= levelMilestones.length) return levelMilestones.last;
    return levelMilestones[currentLevel];
  }
}
