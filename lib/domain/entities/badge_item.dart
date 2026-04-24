import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/constants/app_assets.dart';

class BadgeItem {
  final String id;
  final String nameKey;
  final String descriptionKey;
  final String iconUrl; // Or local asset path

  const BadgeItem({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    required this.iconUrl,
  });

  /// Resolve localized name via l10n
  String get name => _resolveName(nameKey);

  /// Resolve localized description via l10n
  String get description => _resolveDescription(descriptionKey);

  static String _resolveName(String key) {
    final l10n = S.current;
    return switch (key) {
      'badgeNewbieName' => l10n.badgeNewbieName,
      'badgeFirstCleanName' => l10n.badgeFirstCleanName,
      'badgeCleaner10Name' => l10n.badgeCleaner10Name,
      'badgeCleaner100Name' => l10n.badgeCleaner100Name,
      'badgeCleaner1000Name' => l10n.badgeCleaner1000Name,
      'badgeBlurry10Name' => l10n.badgeBlurry10Name,
      'badgeBlurryKillerName' => l10n.badgeBlurryKillerName,
      'badgeBlurry200Name' => l10n.badgeBlurry200Name,
      'badgeDuplicate20Name' => l10n.badgeDuplicate20Name,
      'badgeDuplicate100Name' => l10n.badgeDuplicate100Name,
      'badgeFreed100mbName' => l10n.badgeFreed100mbName,
      'badgeGigaKingName' => l10n.badgeGigaKingName,
      'badgeFreed5gbName' => l10n.badgeFreed5gbName,
      'badgeFreed10gbName' => l10n.badgeFreed10gbName,
      'badgeStreak3Name' => l10n.badgeStreak3Name,
      'badgeStreak7Name' => l10n.badgeStreak7Name,
      'badgeSpeedCleanName' => l10n.badgeSpeedCleanName,
      'badgeAiCleanerName' => l10n.badgeAiCleanerName,
      'badgePerfectionistName' => l10n.badgePerfectionistName,
      _ => key,
    };
  }

  static String _resolveDescription(String key) {
    final l10n = S.current;
    return switch (key) {
      'badgeNewbieDesc' => l10n.badgeNewbieDesc,
      'badgeFirstCleanDesc' => l10n.badgeFirstCleanDesc,
      'badgeCleaner10Desc' => l10n.badgeCleaner10Desc,
      'badgeCleaner100Desc' => l10n.badgeCleaner100Desc,
      'badgeCleaner1000Desc' => l10n.badgeCleaner1000Desc,
      'badgeBlurry10Desc' => l10n.badgeBlurry10Desc,
      'badgeBlurryKillerDesc' => l10n.badgeBlurryKillerDesc,
      'badgeBlurry200Desc' => l10n.badgeBlurry200Desc,
      'badgeDuplicate20Desc' => l10n.badgeDuplicate20Desc,
      'badgeDuplicate100Desc' => l10n.badgeDuplicate100Desc,
      'badgeFreed100mbDesc' => l10n.badgeFreed100mbDesc,
      'badgeGigaKingDesc' => l10n.badgeGigaKingDesc,
      'badgeFreed5gbDesc' => l10n.badgeFreed5gbDesc,
      'badgeFreed10gbDesc' => l10n.badgeFreed10gbDesc,
      'badgeStreak3Desc' => l10n.badgeStreak3Desc,
      'badgeStreak7Desc' => l10n.badgeStreak7Desc,
      'badgeSpeedCleanDesc' => l10n.badgeSpeedCleanDesc,
      'badgeAiCleanerDesc' => l10n.badgeAiCleanerDesc,
      'badgePerfectionistDesc' => l10n.badgePerfectionistDesc,
      _ => key,
    };
  }
}

// Sample Badges
class AppBadges {
  // ===== BASIC =====
  static const BadgeItem newbie = BadgeItem(
    id: 'newbie',
    nameKey: 'badgeNewbieName',
    descriptionKey: 'badgeNewbieDesc',
    iconUrl: AppAssets.badgeNewbie,
  );

  static const BadgeItem firstClean = BadgeItem(
    id: 'first_clean',
    nameKey: 'badgeFirstCleanName',
    descriptionKey: 'badgeFirstCleanDesc',
    iconUrl: AppAssets.badgeFirstClean,
  );

  // ===== DELETE COUNT =====
  static const BadgeItem cleaner10 = BadgeItem(
    id: 'cleaner_10',
    nameKey: 'badgeCleaner10Name',
    descriptionKey: 'badgeCleaner10Desc',
    iconUrl: AppAssets.badgeCleaner10,
  );

  static const BadgeItem cleaner100 = BadgeItem(
    id: 'cleaner_100',
    nameKey: 'badgeCleaner100Name',
    descriptionKey: 'badgeCleaner100Desc',
    iconUrl: AppAssets.badgeCleaner100,
  );

  static const BadgeItem cleaner1000 = BadgeItem(
    id: 'cleaner_1000',
    nameKey: 'badgeCleaner1000Name',
    descriptionKey: 'badgeCleaner1000Desc',
    iconUrl: AppAssets.badgeCleaner1000,
  );

  // ===== BLURRY =====
  static const BadgeItem blurryHunter = BadgeItem(
    id: 'blurry_10',
    nameKey: 'badgeBlurry10Name',
    descriptionKey: 'badgeBlurry10Desc',
    iconUrl: AppAssets.badgeBlurry10,
  );

  static const BadgeItem blurryKiller = BadgeItem(
    id: 'blurry_killer',
    nameKey: 'badgeBlurryKillerName',
    descriptionKey: 'badgeBlurryKillerDesc',
    iconUrl: AppAssets.badgeBlurryKiller,
  );

  static const BadgeItem blurryDestroyer = BadgeItem(
    id: 'blurry_200',
    nameKey: 'badgeBlurry200Name',
    descriptionKey: 'badgeBlurry200Desc',
    iconUrl: AppAssets.badgeBlurry200,
  );

  // ===== DUPLICATE =====
  static const BadgeItem duplicateFinder = BadgeItem(
    id: 'duplicate_20',
    nameKey: 'badgeDuplicate20Name',
    descriptionKey: 'badgeDuplicate20Desc',
    iconUrl: AppAssets.badgeDuplicate20,
  );

  static const BadgeItem duplicateMaster = BadgeItem(
    id: 'duplicate_100',
    nameKey: 'badgeDuplicate100Name',
    descriptionKey: 'badgeDuplicate100Desc',
    iconUrl: AppAssets.badgeDuplicate100,
  );

  // ===== STORAGE =====
  static const BadgeItem freed100mb = BadgeItem(
    id: 'freed_100mb',
    nameKey: 'badgeFreed100mbName',
    descriptionKey: 'badgeFreed100mbDesc',
    iconUrl: AppAssets.badgeFreed100mb,
  );

  static const BadgeItem gigabyteKing = BadgeItem(
    id: 'giga_king',
    nameKey: 'badgeGigaKingName',
    descriptionKey: 'badgeGigaKingDesc',
    iconUrl: AppAssets.badgeGigaKing,
  );

  static const BadgeItem freed5gb = BadgeItem(
    id: 'freed_5gb',
    nameKey: 'badgeFreed5gbName',
    descriptionKey: 'badgeFreed5gbDesc',
    iconUrl: AppAssets.badgeFreed5gb,
  );

  static const BadgeItem freed10gb = BadgeItem(
    id: 'freed_10gb',
    nameKey: 'badgeFreed10gbName',
    descriptionKey: 'badgeFreed10gbDesc',
    iconUrl: AppAssets.badgeFreed10gb,
  );

  // ===== STREAK =====
  static const BadgeItem streak3 = BadgeItem(
    id: 'streak_3',
    nameKey: 'badgeStreak3Name',
    descriptionKey: 'badgeStreak3Desc',
    iconUrl: AppAssets.badgeStreak3,
  );

  static const BadgeItem streak7 = BadgeItem(
    id: 'streak_7',
    nameKey: 'badgeStreak7Name',
    descriptionKey: 'badgeStreak7Desc',
    iconUrl: AppAssets.badgeStreak7,
  );

  // ===== SPECIAL =====
  static const BadgeItem speedCleaner = BadgeItem(
    id: 'speed_clean',
    nameKey: 'badgeSpeedCleanName',
    descriptionKey: 'badgeSpeedCleanDesc',
    iconUrl: AppAssets.badgeSpeedClean,
  );

  static const BadgeItem aiUser = BadgeItem(
    id: 'ai_cleaner',
    nameKey: 'badgeAiCleanerName',
    descriptionKey: 'badgeAiCleanerDesc',
    iconUrl: AppAssets.badgeAiCleaner,
  );

  static const BadgeItem perfectionist = BadgeItem(
    id: 'perfectionist',
    nameKey: 'badgePerfectionistName',
    descriptionKey: 'badgePerfectionistDesc',
    iconUrl: AppAssets.badgePerfectionist,
  );

  // ===== ALL =====
  static const List<BadgeItem> allBadges = [
    newbie,
    firstClean,

    cleaner10,
    cleaner100,
    cleaner1000,

    blurryHunter,
    blurryKiller,
    blurryDestroyer,

    duplicateFinder,
    duplicateMaster,

    freed100mb,
    gigabyteKing,
    freed5gb,
    freed10gb,

    streak3,
    streak7,

    speedCleaner,
    aiUser,
    perfectionist,
  ];

  /// Find a badge by ID
  static BadgeItem? findById(String id) {
    try {
      return allBadges.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
