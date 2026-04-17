import 'package:twinfix/domain/entities/user_profile.dart';

/// Service thuần logic (không dependency) để đánh giá achievements.
/// Được thiết kế để có thể test dễ dàng.
class AchievementService {
  const AchievementService._();

  // ==================== Byte thresholds ====================
  static const int _100Mb = 100 * 1024 * 1024;
  static const int _1Gb = 1024 * 1024 * 1024;
  static const int _5Gb = 5 * 1024 * 1024 * 1024;
  static const int _10Gb = 10 * 1024 * 1024 * 1024;

  /// Badge rules: badge ID → condition function
  static final Map<String, bool Function(UserProfile)> _badgeRules = {
    // BASIC — cả newbie và first_clean đều cấp khi xóa ảnh lần đầu
    'newbie': (p) => p.totalDeletedPhotos >= 1,
    'first_clean': (p) => p.totalDeletedPhotos >= 1,

    // DELETE COUNT
    'cleaner_10': (p) => p.totalDeletedPhotos >= 10,
    'cleaner_100': (p) => p.totalDeletedPhotos >= 100,
    'cleaner_1000': (p) => p.totalDeletedPhotos >= 1000,

    // BLURRY
    'blurry_10': (p) => p.blurryDeletedPhotos >= 10,
    'blurry_killer': (p) => p.blurryDeletedPhotos >= 50,
    'blurry_200': (p) => p.blurryDeletedPhotos >= 200,

    // DUPLICATE
    'duplicate_20': (p) => p.duplicateDeletedPhotos >= 20,
    'duplicate_100': (p) => p.duplicateDeletedPhotos >= 100,

    // STORAGE
    'freed_100mb': (p) => p.totalCleanedBytes >= _100Mb,
    'giga_king': (p) => p.totalCleanedBytes >= _1Gb,
    'freed_5gb': (p) => p.totalCleanedBytes >= _5Gb,
    'freed_10gb': (p) => p.totalCleanedBytes >= _10Gb,

    // STREAK
    'streak_3': (p) => p.streakDays >= 3,
    'streak_7': (p) => p.streakDays >= 7,

    // SPECIAL
    'speed_clean': (p) => p.maxDeletedInOneSession >= 50,
    'ai_cleaner': (p) => p.hasUsedAiCleaner,

    // perfectionist: bỏ qua cho MVP (cần biết tổng ảnh mờ trên device)
    // 'perfectionist': (p) => ...,
  };

  /// Đánh giá tất cả badges và trả về danh sách badge IDs **MỚI** đạt được
  /// (chưa có trong profile.badgeIds).
  static List<String> evaluateNewBadges(UserProfile profile) {
    final existingBadges = profile.badgeIds.toSet();
    final newBadges = <String>[];

    for (final entry in _badgeRules.entries) {
      final badgeId = entry.key;
      final condition = entry.value;

      // Chỉ check badge chưa đạt
      if (!existingBadges.contains(badgeId) && condition(profile)) {
        newBadges.add(badgeId);
      }
    }

    return newBadges;
  }

  /// Tính streak dựa trên lần dọn dẹp cuối cùng.
  /// Rules:
  /// - Nếu lastCleanedAt là hôm nay → không tăng streak (đã tính rồi)
  /// - Nếu lastCleanedAt là hôm qua → streak + 1
  /// - Nếu lastCleanedAt > 1 ngày trước → reset streak về 1
  /// - Nếu chưa bao giờ dọn → streak = 1
  static int calculateStreak({
    required DateTime? lastCleanedAt,
    required int currentStreak,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastCleanedAt == null) {
      return 1; // Lần dọn đầu tiên
    }

    final lastDate = DateTime(
      lastCleanedAt.year,
      lastCleanedAt.month,
      lastCleanedAt.day,
    );

    final daysDiff = today.difference(lastDate).inDays;

    if (daysDiff == 0) {
      // Đã dọn hôm nay rồi → giữ nguyên streak
      return currentStreak;
    } else if (daysDiff == 1) {
      // Dọn hôm qua → tăng streak
      return currentStreak + 1;
    } else {
      // Hơn 1 ngày không dọn → reset
      return 1;
    }
  }
}
