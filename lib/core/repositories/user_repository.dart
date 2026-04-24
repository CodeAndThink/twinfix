import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/core/services/achievement_service.dart';
import 'package:twinfix/data/models/user_profile_db.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/deletion_history.dart';
import '../../data/models/deletion_history_db.dart';
import '../services/auth_service.dart';

/// Kết quả của một phiên dọn dẹp, bao gồm profile mới và badges mới đạt được
class DeletionResult {
  final UserProfile updatedProfile;
  final List<String> newBadgeIds;

  const DeletionResult({
    required this.updatedProfile,
    this.newBadgeIds = const [],
  });
}

@lazySingleton
class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService authService;
  final Isar isar;

  final StreamController<UserProfile> _profileController =
      StreamController<UserProfile>.broadcast();

  UserRepository({required this.authService, required this.isar});

  /// Theo dõi sự thay đổi của User Profile
  Stream<UserProfile> watchUserProfile() => _profileController.stream;

  /// Lấy thông tin user hiện tại
  Future<UserProfile> getUserProfile() async {
    final user = authService.currentUser;
    if (user == null) {
      // Chế độ khách: Lấy từ Isar
      final localProfile = await isar.userProfileDbs.get(0);
      if (localProfile != null) {
        return UserProfile.fromDb(localProfile);
      }
      return const UserProfile(id: 'guest');
    }

    try {
      final response = await _client
          .from('user_profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response != null) {
        return UserProfile.fromJson(response);
      } else {
        // Tạo profile mới trên Supabase nếu chưa có
        final newProfile = UserProfile(id: user.id);
        await _client.from('user_profiles').insert(newProfile.toJson());
        return newProfile;
      }
    } catch (e) {
      debugPrint('Supabase error, returning local mock data: $e');
      return UserProfile(id: user.id, totalCleanedBytes: 0, streakDays: 0);
    }
  }

  /// Ghi nhận một phiên xóa ảnh và tự động đánh giá achievement.
  ///
  /// [bytesFreed] — Tổng dung lượng đã giải phóng (bytes)
  /// [totalCount] — Tổng số ảnh đã xóa trong phiên này
  /// [blurryCount] — Số ảnh mờ đã xóa trong phiên này
  /// [duplicateCount] — Số ảnh trùng đã xóa trong phiên này
  Future<DeletionResult> recordDeletion({
    required int bytesFreed,
    required int totalCount,
    int blurryCount = 0,
    int duplicateCount = 0,
  }) async {
    final profile = await getUserProfile();

    // 1. Cập nhật stats
    final newTotalBytes = profile.totalCleanedBytes + bytesFreed;
    final newTotalDeleted = profile.totalDeletedPhotos + totalCount;
    final newBlurryDeleted = profile.blurryDeletedPhotos + blurryCount;
    final newDuplicateDeleted = profile.duplicateDeletedPhotos + duplicateCount;
    final newMaxSession = max(profile.maxDeletedInOneSession, totalCount);

    // 2. Tính streak
    final newStreak = AchievementService.calculateStreak(
      lastCleanedAt: profile.lastCleanedAt,
      currentStreak: profile.streakDays,
    );

    // 3. Tạo profile tạm với stats mới (chưa có badges mới)
    final updatedProfile = profile.copyWith(
      totalCleanedBytes: newTotalBytes,
      totalDeletedPhotos: newTotalDeleted,
      blurryDeletedPhotos: newBlurryDeleted,
      duplicateDeletedPhotos: newDuplicateDeleted,
      maxDeletedInOneSession: newMaxSession,
      streakDays: newStreak,
      lastCleanedAt: DateTime.now(),
    );

    // 4. Đánh giá badges mới
    final newBadgeIds = AchievementService.evaluateNewBadges(updatedProfile);
    final allBadgeIds = [...updatedProfile.badgeIds, ...newBadgeIds];

    // 5. Profile cuối cùng với badges mới
    final finalProfile = updatedProfile.copyWith(badgeIds: allBadgeIds);

    // 6. Persist
    await _persistProfile(finalProfile);

    // 6.1 Save Deletion History
    if (totalCount > 0) {
      await saveDeletionHistory(
        DeletionHistory(
          timestamp: DateTime.now(),
          totalCount: totalCount,
          bytesFreed: bytesFreed,
          blurryCount: blurryCount,
          duplicateCount: duplicateCount,
        ),
      );
    }

    // 7. Emit
    _profileController.add(finalProfile);

    return DeletionResult(
      updatedProfile: finalProfile,
      newBadgeIds: newBadgeIds,
    );
  }

  /// Cập nhật dung lượng bộ nhớ đã dọn (backward-compatible, delegates to recordDeletion)
  Future<UserProfile> addCleanedBytes(int bytes) async {
    final result = await recordDeletion(bytesFreed: bytes, totalCount: 0);
    return result.updatedProfile;
  }

  /// Persist profile to local DB or remote
  Future<void> _persistProfile(UserProfile profile) async {
    final user = authService.currentUser;

    if (user == null) {
      // Chế độ khách: Cập nhật Isar
      final dbItem = profile.toDb();
      await isar.writeTxn(() => isar.userProfileDbs.put(dbItem));
    } else {
      try {
        await _client
            .from('user_profiles')
            .update(profile.toJson())
            .eq('id', user.id);
      } catch (e) {
        debugPrint('Error persisting profile to Supabase: $e');
        rethrow;
      }
    }
  }

  /// Đồng bộ dữ liệu từ Guest sang Account mới
  Future<void> syncGuestProfile(bool shouldMerge) async {
    final user = authService.currentUser;
    if (user == null) return;

    final localProfile = await isar.userProfileDbs.get(0);
    if (localProfile == null) return;

    if (shouldMerge) {
      final remoteProfile = await getUserProfile();
      // Cộng dồn dữ liệu
      final mergedBytes =
          remoteProfile.totalCleanedBytes + localProfile.totalCleanedBytes;
      final mergedDeletedPhotos =
          remoteProfile.totalDeletedPhotos + localProfile.totalDeletedPhotos;
      final mergedBlurryDeleted =
          remoteProfile.blurryDeletedPhotos + localProfile.blurryDeletedPhotos;
      final mergedDuplicateDeleted =
          remoteProfile.duplicateDeletedPhotos +
          localProfile.duplicateDeletedPhotos;
      final mergedMaxSession = max(
        remoteProfile.maxDeletedInOneSession,
        localProfile.maxDeletedInOneSession,
      );

      // Hợp nhất BadgeIds (Unique)
      final mergedBadges =
          (remoteProfile.badgeIds.toSet()..addAll(localProfile.badgeIds))
              .toList();

      await _client
          .from('user_profiles')
          .update({
            'total_cleaned_bytes': mergedBytes,
            'badge_ids': mergedBadges,
            'total_deleted_photos': mergedDeletedPhotos,
            'blurry_deleted_photos': mergedBlurryDeleted,
            'duplicate_deleted_photos': mergedDuplicateDeleted,
            'max_deleted_in_one_session': mergedMaxSession,
            'has_used_ai_cleaner':
                remoteProfile.hasUsedAiCleaner || localProfile.hasUsedAiCleaner,
          })
          .eq('id', user.id);

      final updatedProfile = await getUserProfile();
      _profileController.add(updatedProfile);
    }

    // Sau khi xử lý (merge hoặc bỏ qua), xóa dữ liệu guest
    await isar.writeTxn(() => isar.userProfileDbs.delete(0));
  }

  /// Lưu lịch sử xóa
  Future<void> saveDeletionHistory(DeletionHistory history) async {
    await isar.writeTxn(() => isar.deletionHistoryDbs.put(history.toDb()));
  }

  /// Lấy toàn bộ lịch sử xóa, sắp xếp theo thời gian mới nhất
  Future<List<DeletionHistory>> getDeletionHistory() async {
    final dbs =
        await isar.deletionHistoryDbs.where().sortByTimestampDesc().findAll();
    return dbs.map(DeletionHistory.fromDb).toList();
  }
}
