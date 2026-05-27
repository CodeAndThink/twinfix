import 'package:twinfix/domain/entities/user_profile.dart';

/// Pure logic service (no dependency) for evaluating achievements.
/// Designed for easy testing.
class AchievementService {
  const AchievementService._();

  // ==================== Achievement thresholds ====================

  /// Badge rules: badge ID → condition function
  static final Map<String, bool Function(UserProfile)> _badgeRules = {
    // BASIC — both newbie and first_clean are awarded upon first deletion
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

    // STORAGE (Now based on photo counts)
    'freed_100mb': (p) => p.totalDeletedPhotos >= 200,
    'giga_king': (p) => p.totalDeletedPhotos >= 500,
    'freed_5gb': (p) => p.totalDeletedPhotos >= 2000,
    'freed_10gb': (p) => p.totalDeletedPhotos >= 5000,

    // STREAK
    'streak_3': (p) => p.streakDays >= 3,
    'streak_7': (p) => p.streakDays >= 7,

    // SPECIAL
    'speed_clean': (p) => p.maxDeletedInOneSession >= 50,
    'ai_cleaner': (p) => p.hasUsedAiCleaner,

    // perfectionist: ignored for MVP (requires knowing total blurry photos on device)
    // 'perfectionist': (p) => ...,
  };

  /// Evaluate all badges and return the list of **NEW** badge IDs earned
  /// (not already in profile.badgeIds).
  static List<String> evaluateNewBadges(UserProfile profile) {
    final existingBadges = profile.badgeIds.toSet();
    final newBadges = <String>[];

    for (final entry in _badgeRules.entries) {
      final badgeId = entry.key;
      final condition = entry.value;

      // Only check badges not yet achieved
      if (!existingBadges.contains(badgeId) && condition(profile)) {
        newBadges.add(badgeId);
      }
    }

    return newBadges;
  }

  /// Calculate streak based on the last cleanup session.
  /// Rules:
  /// - If lastCleanedAt is today -> do not increase streak (already calculated)
  /// - If lastCleanedAt is yesterday -> streak + 1
  /// - If lastCleanedAt > 1 day ago -> reset streak to 1
  /// - If never cleaned before -> streak = 1
  static int calculateStreak({
    required DateTime? lastCleanedAt,
    required int currentStreak,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastCleanedAt == null) {
      return 1; // First cleanup
    }

    final lastDate = DateTime(
      lastCleanedAt.year,
      lastCleanedAt.month,
      lastCleanedAt.day,
    );

    final daysDiff = today.difference(lastDate).inDays;

    if (daysDiff == 0) {
      // Cleaned today -> keep the same streak
      return currentStreak;
    } else if (daysDiff == 1) {
      // Cleaned yesterday -> increment streak
      return currentStreak + 1;
    } else {
      // Not cleaned for more than 1 day -> reset
      return 1;
    }
  }
}
