import 'package:twinfix/core/configs/app_configs.dart';
import '../../data/models/user_profile_db.dart';

class UserProfile {
  final String id;
  final int totalCleanedBytes;
  final int streakDays;
  final List<String> badgeIds;
  final DateTime? lastCleanedAt;
  final bool isPro;

  const UserProfile({
    required this.id,
    this.totalCleanedBytes = 0,
    this.streakDays = 0,
    this.badgeIds = const [],
    this.lastCleanedAt,
    this.isPro = false,
  });

  UserProfile copyWith({
    String? id,
    int? totalCleanedBytes,
    int? streakDays,
    List<String>? badgeIds,
    DateTime? lastCleanedAt,
    bool? isPro,
  }) {
    return UserProfile(
      id: id ?? this.id,
      totalCleanedBytes: totalCleanedBytes ?? this.totalCleanedBytes,
      streakDays: streakDays ?? this.streakDays,
      badgeIds: badgeIds ?? this.badgeIds,
      lastCleanedAt: lastCleanedAt ?? this.lastCleanedAt,
      isPro: isPro ?? this.isPro,
    );
  }

  /// Tính toán Level hiện tại dựa trên tổng số bytes đã dọn dẹp
  int get currentLevel => AppConfigs.getLevelFromBytes(totalCleanedBytes);

  /// Tính toán % tiến trình của Level hiện tại (để vẽ thanh Progress)
  double get levelProgress => AppConfigs.getLevelProgress(totalCleanedBytes);

  factory UserProfile.fromDb(UserProfileDb db) {
    return UserProfile(
      id: 'guest',
      totalCleanedBytes: db.totalCleanedBytes,
      streakDays: db.streakDays,
      badgeIds: db.badgeIds,
      lastCleanedAt: db.lastCleanedAt,
      isPro: db.isPro,
    );
  }

  UserProfileDb toDb() {
    return UserProfileDb()
      ..totalCleanedBytes = totalCleanedBytes
      ..streakDays = streakDays
      ..badgeIds = badgeIds
      ..lastCleanedAt = lastCleanedAt
      ..isPro = isPro;
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
    };
  }
}
