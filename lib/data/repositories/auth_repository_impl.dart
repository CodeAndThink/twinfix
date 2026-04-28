import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/core/services/achievement_service.dart';
import 'package:twinfix/data/models/user_profile_db.dart';
import 'package:twinfix/data/models/deletion_history_db.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/deletion_history.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final Isar isar;

  final StreamController<UserProfile> _profileController =
      StreamController<UserProfile>.broadcast();

  AuthRepositoryImpl({required this.isar});

  @override
  Future<void> login({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  @override
  bool get isAuthenticated => _client.auth.currentUser != null;

  @override
  Stream<UserProfile> watchUserProfile() => _profileController.stream;

  @override
  Future<UserProfile> getUserProfile() async {
    final user = _client.auth.currentUser;
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

  @override
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

    // 4.1 Cập nhật thời điểm nhận badge
    final now = DateTime.now();
    final newEarnedDates = Map<String, DateTime?>.from(
      updatedProfile.badgeEarnedDates,
    );
    for (final badgeId in newBadgeIds) {
      newEarnedDates[badgeId] = now;
    }

    // 5. Profile cuối cùng với badges mới
    final finalProfile = updatedProfile.copyWith(
      badgeIds: allBadgeIds,
      badgeEarnedDates: newEarnedDates,
    );

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

  @override
  Future<UserProfile> addCleanedBytes(int bytes) async {
    final result = await recordDeletion(bytesFreed: bytes, totalCount: 0);
    return result.updatedProfile;
  }

  @override
  Future<void> syncGuestProfile(bool shouldMerge) async {
    final user = _client.auth.currentUser;
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

      // Hợp nhất thời điểm nhận badge
      final localProfileEntity = UserProfile.fromDb(localProfile);
      final mergedEarnedDates = Map<String, DateTime?>.from(
        remoteProfile.badgeEarnedDates,
      )..addAll(localProfileEntity.badgeEarnedDates);

      await _client
          .from('user_profiles')
          .update({
            'total_cleaned_bytes': mergedBytes,
            'badge_ids': mergedBadges,
            'badge_earned_dates': mergedEarnedDates.map(
              (key, value) => MapEntry(key, value?.toIso8601String()),
            ),
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

  @override
  Future<void> saveDeletionHistory(DeletionHistory history) async {
    await isar.writeTxn(() => isar.deletionHistoryDbs.put(history.toDb()));
  }

  @override
  Future<List<DeletionHistory>> getDeletionHistory() async {
    final dbs = await isar.deletionHistoryDbs
        .where()
        .sortByTimestampDesc()
        .findAll();
    return dbs.map(DeletionHistory.fromDb).toList();
  }

  /// Persist profile to local DB or remote
  Future<void> _persistProfile(UserProfile profile) async {
    final user = _client.auth.currentUser;

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
}
