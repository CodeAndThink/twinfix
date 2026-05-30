import 'package:twinfix/core/utils/app_utils.dart';
import '../../data/models/user_profile_db.dart';
import '../../data/models/sync_status.dart';

class UserProfile {
  final String id;
  final int totalCleanedBytes;
  final int streakDays;
  final List<String> badgeIds;
  final Map<String, DateTime?> badgeEarnedDates;
  final DateTime? lastCleanedAt;
  final bool isPro;

  // Achievement tracking counters
  final int totalDeletedPhotos;
  final int blurryDeletedPhotos;
  final int duplicateDeletedPhotos;
  final int maxDeletedInOneSession;
  final bool hasUsedAiCleaner;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Offline-first sync metadata
  final int localId;
  final SyncStatus syncStatus;
  final bool isGuest;

  const UserProfile({
    required this.id,
    this.totalCleanedBytes = 0,
    this.streakDays = 0,
    this.badgeIds = const [],
    this.badgeEarnedDates = const {},
    this.lastCleanedAt,
    this.isPro = false,
    this.totalDeletedPhotos = 0,
    this.blurryDeletedPhotos = 0,
    this.duplicateDeletedPhotos = 0,
    this.maxDeletedInOneSession = 0,
    this.hasUsedAiCleaner = false,
    this.createdAt,
    this.updatedAt,
    this.localId = 0,
    this.syncStatus = SyncStatus.pendingCreate,
    this.isGuest = true,
  });

  UserProfile copyWith({
    String? id,
    int? totalCleanedBytes,
    int? streakDays,
    List<String>? badgeIds,
    Map<String, DateTime?>? badgeEarnedDates,
    DateTime? lastCleanedAt,
    bool? isPro,
    int? totalDeletedPhotos,
    int? blurryDeletedPhotos,
    int? duplicateDeletedPhotos,
    int? maxDeletedInOneSession,
    bool? hasUsedAiCleaner,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    int? avatarTypeId,
    int? frameTypeId,
    int? localId,
    SyncStatus? syncStatus,
    bool? isGuest,
  }) {
    return UserProfile(
      id: id ?? this.id,
      totalCleanedBytes: totalCleanedBytes ?? this.totalCleanedBytes,
      streakDays: streakDays ?? this.streakDays,
      badgeIds: badgeIds ?? this.badgeIds,
      badgeEarnedDates: badgeEarnedDates ?? this.badgeEarnedDates,
      lastCleanedAt: lastCleanedAt ?? this.lastCleanedAt,
      isPro: isPro ?? this.isPro,
      totalDeletedPhotos: totalDeletedPhotos ?? this.totalDeletedPhotos,
      blurryDeletedPhotos: blurryDeletedPhotos ?? this.blurryDeletedPhotos,
      duplicateDeletedPhotos:
          duplicateDeletedPhotos ?? this.duplicateDeletedPhotos,
      maxDeletedInOneSession:
          maxDeletedInOneSession ?? this.maxDeletedInOneSession,
      hasUsedAiCleaner: hasUsedAiCleaner ?? this.hasUsedAiCleaner,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      localId: localId ?? this.localId,
      syncStatus: syncStatus ?? this.syncStatus,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  /// Calculate current Level based on total deleted photos/videos
  int get currentLevel => AppUtils.getLevelFromCount(totalDeletedPhotos);

  /// Calculate the progression percentage of current Level (for rendering the progress bar)
  double get levelProgress => AppUtils.getLevelProgress(totalDeletedPhotos);

  factory UserProfile.fromDb(UserProfileDb db) {
    return UserProfile(
      id: db.remoteId ?? 'guest',
      totalCleanedBytes: db.totalCleanedBytes,
      streakDays: db.streakDays,
      badgeIds: db.badgeIds,
      badgeEarnedDates: Map.fromIterables(
        db.badgeIds,
        List.generate(
          db.badgeIds.length,
          (index) => index < db.badgeEarnedDates.length
              ? db.badgeEarnedDates[index]
              : null,
        ),
      ),
      lastCleanedAt: db.lastCleanedAt,
      isPro: db.isPro,
      totalDeletedPhotos: db.totalDeletedPhotos,
      blurryDeletedPhotos: db.blurryDeletedPhotos,
      duplicateDeletedPhotos: db.duplicateDeletedPhotos,
      maxDeletedInOneSession: db.maxDeletedInOneSession,
      hasUsedAiCleaner: db.hasUsedAiCleaner,
      localId: db.id,
      syncStatus: db.syncStatus,
      isGuest: db.isGuest,
    );
  }

  UserProfileDb toDb() {
    return UserProfileDb()
      ..remoteId = id != 'guest' ? id : null
      ..totalCleanedBytes = totalCleanedBytes
      ..streakDays = streakDays
      ..badgeIds = badgeIds
      ..badgeEarnedDates = badgeIds.map((id) => badgeEarnedDates[id]).toList()
      ..lastCleanedAt = lastCleanedAt
      ..isPro = isPro
      ..totalDeletedPhotos = totalDeletedPhotos
      ..blurryDeletedPhotos = blurryDeletedPhotos
      ..duplicateDeletedPhotos = duplicateDeletedPhotos
      ..maxDeletedInOneSession = maxDeletedInOneSession
      ..hasUsedAiCleaner = hasUsedAiCleaner
      ..syncStatus = syncStatus
      ..isGuest = isGuest
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      totalCleanedBytes: json['total_cleaned_bytes'] as int? ?? 0,
      streakDays: json['streak_days'] as int? ?? 0,
      badgeIds: List<String>.from(json['badge_ids'] ?? []),
      badgeEarnedDates:
          (json['badge_earned_dates'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, DateTime.parse(value as String)),
          ) ??
          {},
      lastCleanedAt: json['last_cleaned_at'] != null
          ? DateTime.parse(json['last_cleaned_at'])
          : null,
      isPro: json['is_pro'] as bool? ?? false,
      totalDeletedPhotos: json['total_deleted_photos'] as int? ?? 0,
      blurryDeletedPhotos: json['blurry_deleted_photos'] as int? ?? 0,
      duplicateDeletedPhotos: json['duplicate_deleted_photos'] as int? ?? 0,
      maxDeletedInOneSession: json['max_deleted_in_one_session'] as int? ?? 0,
      hasUsedAiCleaner: json['has_used_ai_cleaner'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      syncStatus: SyncStatus.synced,
      isGuest: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_cleaned_bytes': totalCleanedBytes,
      'streak_days': streakDays,
      'badge_ids': badgeIds,
      'badge_earned_dates': badgeEarnedDates.map(
        (key, value) => MapEntry(key, value?.toIso8601String()),
      ),
      'last_cleaned_at': lastCleanedAt?.toIso8601String(),
      'is_pro': isPro,
      'total_deleted_photos': totalDeletedPhotos,
      'blurry_deleted_photos': blurryDeletedPhotos,
      'duplicate_deleted_photos': duplicateDeletedPhotos,
      'max_deleted_in_one_session': maxDeletedInOneSession,
      'has_used_ai_cleaner': hasUsedAiCleaner,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
    };
  }
}
