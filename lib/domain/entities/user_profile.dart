import 'package:twinfix/core/utils/app_utils.dart';
import '../../data/models/user_profile_db.dart';

class UserProfile {
  final String id;
  final int totalCleanedBytes;
  final int streakDays;
  final List<String> badgeIds;
  final DateTime? lastCleanedAt;
  final bool isPro;

  // Achievement tracking counters
  final int totalDeletedPhotos;
  final int blurryDeletedPhotos;
  final int duplicateDeletedPhotos;
  final int maxDeletedInOneSession;
  final bool hasUsedAiCleaner;

  const UserProfile({
    required this.id,
    this.totalCleanedBytes = 0,
    this.streakDays = 0,
    this.badgeIds = const [],
    this.lastCleanedAt,
    this.isPro = false,
    this.totalDeletedPhotos = 0,
    this.blurryDeletedPhotos = 0,
    this.duplicateDeletedPhotos = 0,
    this.maxDeletedInOneSession = 0,
    this.hasUsedAiCleaner = false,
  });

  UserProfile copyWith({
    String? id,
    int? totalCleanedBytes,
    int? streakDays,
    List<String>? badgeIds,
    DateTime? lastCleanedAt,
    bool? isPro,
    int? totalDeletedPhotos,
    int? blurryDeletedPhotos,
    int? duplicateDeletedPhotos,
    int? maxDeletedInOneSession,
    bool? hasUsedAiCleaner,
  }) {
    return UserProfile(
      id: id ?? this.id,
      totalCleanedBytes: totalCleanedBytes ?? this.totalCleanedBytes,
      streakDays: streakDays ?? this.streakDays,
      badgeIds: badgeIds ?? this.badgeIds,
      lastCleanedAt: lastCleanedAt ?? this.lastCleanedAt,
      isPro: isPro ?? this.isPro,
      totalDeletedPhotos: totalDeletedPhotos ?? this.totalDeletedPhotos,
      blurryDeletedPhotos: blurryDeletedPhotos ?? this.blurryDeletedPhotos,
      duplicateDeletedPhotos:
          duplicateDeletedPhotos ?? this.duplicateDeletedPhotos,
      maxDeletedInOneSession:
          maxDeletedInOneSession ?? this.maxDeletedInOneSession,
      hasUsedAiCleaner: hasUsedAiCleaner ?? this.hasUsedAiCleaner,
    );
  }

  /// Tính toán Level hiện tại dựa trên tổng số ảnh/video đã xóa
  int get currentLevel => AppUtils.getLevelFromCount(totalDeletedPhotos);

  /// Tính toán % tiến trình của Level hiện tại (để vẽ thanh Progress)
  double get levelProgress => AppUtils.getLevelProgress(totalDeletedPhotos);

  factory UserProfile.fromDb(UserProfileDb db) {
    return UserProfile(
      id: 'guest',
      totalCleanedBytes: db.totalCleanedBytes,
      streakDays: db.streakDays,
      badgeIds: db.badgeIds,
      lastCleanedAt: db.lastCleanedAt,
      isPro: db.isPro,
      totalDeletedPhotos: db.totalDeletedPhotos,
      blurryDeletedPhotos: db.blurryDeletedPhotos,
      duplicateDeletedPhotos: db.duplicateDeletedPhotos,
      maxDeletedInOneSession: db.maxDeletedInOneSession,
      hasUsedAiCleaner: db.hasUsedAiCleaner,
    );
  }

  UserProfileDb toDb() {
    return UserProfileDb()
      ..totalCleanedBytes = totalCleanedBytes
      ..streakDays = streakDays
      ..badgeIds = badgeIds
      ..lastCleanedAt = lastCleanedAt
      ..isPro = isPro
      ..totalDeletedPhotos = totalDeletedPhotos
      ..blurryDeletedPhotos = blurryDeletedPhotos
      ..duplicateDeletedPhotos = duplicateDeletedPhotos
      ..maxDeletedInOneSession = maxDeletedInOneSession
      ..hasUsedAiCleaner = hasUsedAiCleaner;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      totalCleanedBytes: json['total_cleaned_bytes'] as int? ?? 0,
      streakDays: json['streak_days'] as int? ?? 0,
      badgeIds: List<String>.from(json['badge_ids'] ?? []),
      lastCleanedAt: json['last_cleaned_at'] != null
          ? DateTime.parse(json['last_cleaned_at'])
          : null,
      isPro: json['is_pro'] as bool? ?? false,
      totalDeletedPhotos: json['total_deleted_photos'] as int? ?? 0,
      blurryDeletedPhotos: json['blurry_deleted_photos'] as int? ?? 0,
      duplicateDeletedPhotos: json['duplicate_deleted_photos'] as int? ?? 0,
      maxDeletedInOneSession: json['max_deleted_in_one_session'] as int? ?? 0,
      hasUsedAiCleaner: json['has_used_ai_cleaner'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_cleaned_bytes': totalCleanedBytes,
      'streak_days': streakDays,
      'badge_ids': badgeIds,
      'last_cleaned_at': lastCleanedAt?.toIso8601String(),
      'is_pro': isPro,
      'total_deleted_photos': totalDeletedPhotos,
      'blurry_deleted_photos': blurryDeletedPhotos,
      'duplicate_deleted_photos': duplicateDeletedPhotos,
      'max_deleted_in_one_session': maxDeletedInOneSession,
      'has_used_ai_cleaner': hasUsedAiCleaner,
    };
  }
}
