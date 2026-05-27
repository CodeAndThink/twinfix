import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/data/models/user_profile_db.dart';
import 'package:twinfix/data/models/deletion_history_db.dart';
import 'package:twinfix/data/models/sync_status.dart';
import 'package:twinfix/domain/params/update_profile_params.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/deletion_history.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:twinfix/core/services/achievement_service.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final Isar isar;
  final googleSignIn = GoogleSignIn.instance;

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
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('User not logged in or email not found');
    }

    // Verify old password
    await _client.auth.signInWithPassword(
      email: user.email!,
      password: oldPassword,
    );

    // Update password
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) {
      throw Exception('No ID Token found.');
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  @override
  Future<bool> hasUnsyncedData() async {
    final unsyncedProfiles = await isar.userProfileDbs
        .filter()
        .not()
        .syncStatusEqualTo(SyncStatus.synced)
        .count();

    final unsyncedHistory = await isar.deletionHistoryDbs
        .filter()
        .not()
        .syncStatusEqualTo(SyncStatus.synced)
        .count();

    return unsyncedProfiles > 0 || unsyncedHistory > 0;
  }

  @override
  Future<void> logout({bool force = false}) async {
    if (!force) {
      final hasUnsynced = await hasUnsyncedData();
      if (hasUnsynced) {
        throw UnsyncedDataException();
      }
    }

    await _client.auth.signOut();

    // Clear user-specific data upon logout
    await isar.writeTxn(() async {
      await isar.userProfileDbs.clear();
      await isar.deletionHistoryDbs.clear();
    });
  }

  @override
  bool get isAuthenticated => _client.auth.currentUser != null;

  @override
  Future<void> updateProfile({required UpdateProfileParams params}) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client
        .from('user_profiles')
        .update(params.toJson())
        .eq('id', user.id);
    final updatedProfile = await getUserProfile();
    _profileController.add(updatedProfile);
  }

  @override
  Stream<UserProfile> watchUserProfile() => _profileController.stream;

  @override
  Future<UserProfile> getUserProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      // Guest mode: Get from Isar
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
        final profile = UserProfile.fromJson(response);
        // Cache to local
        await _persistLocalOnly(profile);
        return profile;
      } else {
        // Create a new profile on Supabase if it does not exist
        final newProfile = UserProfile(
          id: user.id,
          fullName: user.userMetadata?['full_name'],
        );
        await _client.from('user_profiles').insert(newProfile.toJson());
        await _persistLocalOnly(newProfile);
        return newProfile;
      }
    } catch (e) {
      debugPrint('Supabase error, returning local cache: $e');
      final cached = await getCachedProfile();
      if (cached != null) return cached;
      return UserProfile(id: user.id, totalCleanedBytes: 0, streakDays: 0);
    }
  }

  @override
  Future<UserProfile?> getCachedProfile() async {
    final user = _client.auth.currentUser;
    // For now, we store everything at index 0 for simplicity, or we can use a specific index for logged in users.
    // Given the current UserProfileDb structure, let's use index 0 as the "current active profile" cache.
    final localProfile = await isar.userProfileDbs.get(0);
    if (localProfile != null) {
      final profile = UserProfile.fromDb(localProfile);
      if (user != null) {
        return profile.copyWith(id: user.id);
      }
      return profile;
    }
    return null;
  }

  Future<void> _persistLocalOnly(UserProfile profile) async {
    final dbItem = profile.toDb();
    await isar.writeTxn(() => isar.userProfileDbs.put(dbItem));
  }

  @override
  Future<DeletionResult> recordDeletion({
    required int totalCount,
    required int totalDeletedSize,
    int blurryCount = 0,
    int duplicateCount = 0,
  }) async {
    final profile = await getUserProfile();

    // 1. Update stats
    final newTotalDeleted = profile.totalDeletedPhotos + totalCount;
    final newCleanedBytes = profile.totalCleanedBytes + totalDeletedSize;
    final newBlurryDeleted = profile.blurryDeletedPhotos + blurryCount;
    final newDuplicateDeleted = profile.duplicateDeletedPhotos + duplicateCount;
    final newStreak = AchievementService.calculateStreak(
      lastCleanedAt: profile.lastCleanedAt,
      currentStreak: profile.streakDays,
    );

    // 2. New profile
    final updatedProfile = profile.copyWith(
      totalDeletedPhotos: newTotalDeleted,
      totalCleanedBytes: newCleanedBytes,
      blurryDeletedPhotos: newBlurryDeleted,
      duplicateDeletedPhotos: newDuplicateDeleted,
      streakDays: newStreak,
      lastCleanedAt: DateTime.now(),
    );

    // 3. Evaluate badges
    final newBadgeIds = AchievementService.evaluateNewBadges(updatedProfile);
    final allBadgeIds = [...updatedProfile.badgeIds, ...newBadgeIds];
    final now = DateTime.now();
    final newEarnedDates = Map<String, DateTime?>.from(
      updatedProfile.badgeEarnedDates,
    );
    for (final badgeId in newBadgeIds) {
      newEarnedDates[badgeId] = now;
    }

    final finalProfile = updatedProfile.copyWith(
      badgeIds: allBadgeIds,
      badgeEarnedDates: newEarnedDates,
    );

    // 4. Persist
    await _persistProfile(finalProfile);

    // 5. History
    if (totalCount > 0) {
      await saveDeletionHistory(
        DeletionHistory(
          timestamp: now,
          totalCount: totalCount,
          totalDeletedSize: totalDeletedSize,
          blurryCount: blurryCount,
          duplicateCount: duplicateCount,
        ),
      );
    }

    _profileController.add(finalProfile);

    return DeletionResult(
      updatedProfile: finalProfile,
      newBadgeIds: newBadgeIds,
    );
  }

  @override
  Future<void> syncGuestProfile(bool shouldMerge) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final localProfile = await isar.userProfileDbs.get(0);
    if (localProfile == null) return;

    if (shouldMerge) {
      final remoteProfile = await getUserProfile();
      // Merge logic (simplified here, but similar to before)
      final mergedProfile = remoteProfile.copyWith(
        totalCleanedBytes:
            remoteProfile.totalCleanedBytes + localProfile.totalCleanedBytes,
        totalDeletedPhotos:
            remoteProfile.totalDeletedPhotos + localProfile.totalDeletedPhotos,
        // ... other fields
      );

      await _persistProfile(mergedProfile);
      _profileController.add(mergedProfile);
    }

    // Keep it in index 0 as the current account profile cache, but logic-wise we can clear guest-specific flags if any.
  }

  @override
  Future<void> saveDeletionHistory(DeletionHistory history) async {
    await isar.writeTxn(() => isar.deletionHistoryDbs.put(history.toDb()));

    final user = _client.auth.currentUser;
    if (user != null) {
      try {
        await _client
            .from('deletion_history')
            .insert(history.toJson(userId: user.id));
      } catch (e) {
        debugPrint('Error syncing deletion history to Supabase: $e');
      }
    }
  }

  @override
  Future<List<DeletionHistory>> getDeletionHistory() async {
    final dbs = await isar.deletionHistoryDbs
        .where()
        .sortByTimestampDesc()
        .findAll();
    return dbs.map(DeletionHistory.fromDb).toList();
  }

  Future<void> _persistProfile(UserProfile profile) async {
    final user = _client.auth.currentUser;
    // Always persist to local first
    await _persistLocalOnly(profile);

    if (user != null) {
      try {
        await _client
            .from('user_profiles')
            .update(profile.toJson())
            .eq('id', user.id);
      } catch (e) {
        debugPrint('Error persisting profile to Supabase: $e');
      }
    }
  }

  @override
  Future<void> updateProStatus({required bool isPro}) async {
    final profile = await getUserProfile();
    final updated = profile.copyWith(isPro: isPro);
    await _persistProfile(updated);
    _profileController.add(updated);
  }
}
