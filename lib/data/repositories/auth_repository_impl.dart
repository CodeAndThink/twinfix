import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/data/models/user_profile_db.dart';
import 'package:twinfix/data/models/deletion_history_db.dart';
import 'package:twinfix/data/models/sync_status.dart';
import 'package:twinfix/data/models/sync_strategy.dart';
import 'package:twinfix/domain/params/update_profile_params.dart';
import 'package:twinfix/generated/l10n.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/deletion_history.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:twinfix/core/services/achievement_service.dart';
import 'package:twinfix/core/exceptions/failure.dart';

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
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Failure.fromCode(e.code ?? e.message);
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw Failure.fromCode(e.code ?? e.message);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Failure.fromCode(e.code ?? e.message);
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null || user.email == null) {
        throw Failure(S.current.defaultErrorMessage);
      }

      // Verify old password
      await _client.auth.signInWithPassword(
        email: user.email!,
        password: oldPassword,
      );

      // Update password
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (e) {
      throw Failure.fromCode(e.code ?? e.message);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw Failure(S.current.defaultErrorMessage);
      }
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } on AuthException catch (e) {
      throw Failure.fromCode(e.code ?? e.message);
    }
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
        // Attempt to sync pending data before logging out
        try {
          await syncPendingData();
        } catch (e) {
          debugPrint('Sync failed during logout attempt: $e');
          // Sync failed — notify the caller so the UI can show a warning dialog
          throw UnsyncedDataException(
            'Failed to sync pending data. Some progress may be lost.',
          );
        }
      }
    }

    await _client.auth.signOut();

    // Clear user-specific data upon logout
    await isar.writeTxn(() async {
      await isar.userProfileDbs.clear();
      await isar.deletionHistoryDbs.clear();
    });
  }

  /// Push all pending (unsynced) profiles and deletion histories to Supabase,
  /// then mark them as [SyncStatus.synced] in the local database.
  /// Uses "Last Write Wins" strategy for profile conflict resolution.
  @override
  Future<void> syncPendingData() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    // 1. Pull from Supabase to ensure local DB has latest histories and remoteIds are populated
    await _pullDeletionHistoryFromSupabase(user.id);

    // 2. Sync pending deletion histories
    final unsyncedHistories = await isar.deletionHistoryDbs
        .filter()
        .not()
        .syncStatusEqualTo(SyncStatus.synced)
        .findAll();

    for (final historyDb in unsyncedHistories) {
      final history = DeletionHistory.fromDb(historyDb);
      if (historyDb.remoteId == null) {
        try {
          await _client
              .from('deletion_history')
              .insert(history.toJson(userId: user.id));
        } catch (_) {}
      }

      // Mark as synced locally
      await isar.writeTxn(() async {
        historyDb.syncStatus = SyncStatus.synced;
        await isar.deletionHistoryDbs.put(historyDb);
      });
    }

    // 3. Recalculate stats directly from all history elements
    final allHistories = await getDeletionHistory();

    // --- Sync pending user profiles (Merge badges, apply recalculated stats) ---
    final unsyncedProfiles = await isar.userProfileDbs
        .filter()
        .not()
        .syncStatusEqualTo(SyncStatus.synced)
        .findAll();

    for (final profileDb in unsyncedProfiles) {
      final localProfile = UserProfile.fromDb(profileDb);

      // Fetch remote profile to merge
      final remoteResponse = await _client
          .from('user_profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      UserProfile mergedProfile;
      if (remoteResponse == null) {
        mergedProfile = localProfile.copyWith(id: user.id);
      } else {
        final remoteProfile = UserProfile.fromJson(remoteResponse);

        final mergedBadgeIds = <String>{
          ...remoteProfile.badgeIds,
          ...localProfile.badgeIds,
        }.toList();

        final mergedBadgeDates = <String, DateTime?>{
          ...remoteProfile.badgeEarnedDates,
          ...localProfile.badgeEarnedDates,
        };

        mergedProfile = localProfile.copyWith(
          id: user.id,
          badgeIds: mergedBadgeIds,
          badgeEarnedDates: mergedBadgeDates,
          isPro: remoteProfile.isPro || localProfile.isPro,
          hasUsedAiCleaner:
              remoteProfile.hasUsedAiCleaner || localProfile.hasUsedAiCleaner,
        );
      }

      // Apply dynamically recalculated stats
      mergedProfile = AchievementService.recalculateProfileStats(
        mergedProfile,
        allHistories,
      );

      // Push merged profile to server
      await _client.from('user_profiles').upsert(mergedProfile.toJson());

      // Save locally
      await _persistLocalOnly(
        mergedProfile.copyWith(syncStatus: SyncStatus.synced),
      );
    }
  }

  Future<void> _pullDeletionHistoryFromSupabase(String userId) async {
    try {
      final response = await _client
          .from('deletion_history')
          .select()
          .eq('user_id', userId)
          .order('timestamp', ascending: false);

      final remoteHistories = (response as List)
          .map((e) => DeletionHistory.fromJson(e))
          .toList();

      await isar.writeTxn(() async {
        for (final history in remoteHistories) {
          // Rely on timestamp to prevent duplicates because local records pushed to Supabase
          // initially have remoteId == null.
          final existing = await isar.deletionHistoryDbs
              .filter()
              .timestampEqualTo(history.timestamp)
              .findFirst();

          if (existing == null) {
            await isar.deletionHistoryDbs.put(history.toDb());
          } else if (existing.remoteId == null && history.remoteId != null) {
            // Update local record with Supabase ID
            existing.remoteId = history.remoteId;
            existing.syncStatus = SyncStatus.synced;
            await isar.deletionHistoryDbs.put(existing);
          }
        }
      });
    } catch (e) {
      debugPrint('Error pulling deletion history: $e');
    }
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
      final localProfile = await isar.userProfileDbs.where().findFirst();
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
        await _pullDeletionHistoryFromSupabase(user.id);
        return profile;
      } else {
        // Create a new profile on Supabase if it does not exist
        final newProfile = UserProfile(id: user.id);
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
    final localProfile = await isar.userProfileDbs.where().findFirst();
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
    if (profile.localId > 0) {
      dbItem.id = profile.localId;
    } else {
      final existing = await isar.userProfileDbs.where().findFirst();
      if (existing != null) {
        dbItem.id = existing.id;
      }
    }
    await isar.writeTxn(() => isar.userProfileDbs.put(dbItem));
  }

  @override
  Future<DeletionResult> recordDeletion({
    required int totalCount,
    required int totalDeletedSize,
    int blurryCount = 0,
    int duplicateCount = 0,
  }) async {
    final now = DateTime.now();

    // 1. History first
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

    final profile = await getUserProfile();

    // 2. Recalculate stats directly from all history elements
    final allHistories = await getDeletionHistory();
    final updatedProfile = AchievementService.recalculateProfileStats(
      profile,
      allHistories,
    );

    // 3. Evaluate badges
    final newBadgeIds = AchievementService.evaluateNewBadges(updatedProfile);
    final allBadgeIds = <String>{
      ...updatedProfile.badgeIds,
      ...newBadgeIds,
    }.toList();
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

    // 4. Persist Profile
    await _persistProfile(finalProfile);
    _profileController.add(finalProfile);

    return DeletionResult(
      updatedProfile: finalProfile,
      newBadgeIds: newBadgeIds,
    );
  }

  @override
  Future<void> syncGuestProfile(SyncStrategy strategy) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final localProfileDb = await isar.userProfileDbs.where().findFirst();
    if (localProfileDb == null) return;

    final localProfile = UserProfile.fromDb(localProfileDb);

    switch (strategy) {
      case SyncStrategy.keepLocal:
        // Push local data to server (overwrite remote)
        final updatedProfile = localProfile.copyWith(
          id: user.id,
          isGuest: false,
          syncStatus: SyncStatus.synced,
        );
        await _client.from('user_profiles').upsert(updatedProfile.toJson());
        await _persistLocalOnly(updatedProfile);
        _profileController.add(updatedProfile);

        // Sync local deletion histories to server
        final localHistories = await isar.deletionHistoryDbs
            .filter()
            .isGuestEqualTo(true)
            .findAll();
        for (final historyDb in localHistories) {
          final history = DeletionHistory.fromDb(historyDb);
          try {
            await _client
                .from('deletion_history')
                .insert(history.toJson(userId: user.id));
          } catch (_) {}
          await isar.writeTxn(() async {
            historyDb.syncStatus = SyncStatus.synced;
            historyDb.isGuest = false;
            await isar.deletionHistoryDbs.put(historyDb);
          });
        }

      case SyncStrategy.keepRemote:
        // Discard local, restore from server
        await isar.writeTxn(() async {
          await isar.userProfileDbs.clear();
          await isar.deletionHistoryDbs.clear();
        });

        // Fetch remote profile
        final remoteProfile = await getUserProfile();
        final updatedRemote = remoteProfile.copyWith(
          isGuest: false,
          syncStatus: SyncStatus.synced,
        );
        await _persistLocalOnly(updatedRemote);
        _profileController.add(updatedRemote);

        // Fetch remote deletion history
        final remoteHistories = await _client
            .from('deletion_history')
            .select()
            .eq('user_id', user.id)
            .order('timestamp', ascending: false)
            .limit(50);
        for (final json in remoteHistories) {
          final history = DeletionHistory(
            timestamp: DateTime.parse(json['timestamp']),
            totalCount: json['total_count'] as int? ?? 0,
            totalDeletedSize: json['total_deleted_size'] as int? ?? 0,
            blurryCount: json['blurry_count'] as int? ?? 0,
            duplicateCount: json['duplicate_count'] as int? ?? 0,
            userId: user.id,
            isGuest: false,
            syncStatus: SyncStatus.synced,
          );
          await isar.writeTxn(
            () => isar.deletionHistoryDbs.put(history.toDb()),
          );
        }

      case SyncStrategy.merge:
        final remoteResponse = await _client
            .from('user_profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (strategy == SyncStrategy.keepRemote) {
          if (remoteResponse != null) {
            final remoteProfile = UserProfile.fromJson(remoteResponse);
            await _persistLocalOnly(remoteProfile);
            _profileController.add(remoteProfile);
            await _pullDeletionHistoryFromSupabase(user.id);
          } else {
            // If remote is null, fallback to pushing local
            strategy = SyncStrategy.keepLocal;
          }
        }

        if (strategy == SyncStrategy.merge) {
          // 1. Sync local guest deletion histories to server
          final guestHistories = await isar.deletionHistoryDbs
              .filter()
              .isGuestEqualTo(true)
              .findAll();
          for (final historyDb in guestHistories) {
            final history = DeletionHistory.fromDb(historyDb);
            if (historyDb.remoteId == null) {
              try {
                await _client
                    .from('deletion_history')
                    .insert(history.toJson(userId: user.id));
              } catch (_) {}
            }
            await isar.writeTxn(() async {
              historyDb.syncStatus = SyncStatus.synced;
              historyDb.isGuest = false;
              await isar.deletionHistoryDbs.put(historyDb);
            });
          }

          // 2. Fetch remote histories to combine with local ones
          await _pullDeletionHistoryFromSupabase(user.id);
          final allHistories = await getDeletionHistory();

          // 3. Merge profiles
          UserProfile mergedProfile;
          if (remoteResponse != null) {
            final remoteProfile = UserProfile.fromJson(remoteResponse);

            final mergedBadgeIds = <String>{
              ...remoteProfile.badgeIds,
              ...localProfile.badgeIds,
            }.toList();

            final mergedBadgeDates = <String, DateTime?>{
              ...remoteProfile.badgeEarnedDates,
              ...localProfile.badgeEarnedDates,
            };

            mergedProfile = localProfile.copyWith(
              id: user.id,
              badgeIds: mergedBadgeIds,
              badgeEarnedDates: mergedBadgeDates,
              isPro: remoteProfile.isPro || localProfile.isPro,
              hasUsedAiCleaner:
                  remoteProfile.hasUsedAiCleaner ||
                  localProfile.hasUsedAiCleaner,
              isGuest: false,
              syncStatus: SyncStatus.synced,
            );
          } else {
            // No remote profile — just push local
            mergedProfile = localProfile.copyWith(
              id: user.id,
              isGuest: false,
              syncStatus: SyncStatus.synced,
            );
          }

          // 4. Apply dynamically recalculated stats
          mergedProfile = AchievementService.recalculateProfileStats(
            mergedProfile,
            allHistories,
          );

          // 5. Upsert and save
          await _client.from('user_profiles').upsert(mergedProfile.toJson());
          await _persistLocalOnly(mergedProfile);
          _profileController.add(mergedProfile);
        }
    }
  }

  @override
  Future<void> saveDeletionHistory(DeletionHistory history) async {
    final db = history.toDb();
    await isar.writeTxn(() => isar.deletionHistoryDbs.put(db));

    final user = _client.auth.currentUser;
    if (user != null) {
      try {
        await _client
            .from('deletion_history')
            .insert(history.toJson(userId: user.id));

        // Mark as synced on success
        await isar.writeTxn(() async {
          db.syncStatus = SyncStatus.synced;
          await isar.deletionHistoryDbs.put(db);
        });
      } catch (e) {
        debugPrint('Error syncing deletion history to Supabase: $e');
        // Keep as pendingCreate — SyncService will retry later
      }
    }
  }

  @override
  Future<List<DeletionHistory>> getDeletionHistory({
    int? limit,
    int? offset,
  }) async {
    final query = isar.deletionHistoryDbs.where().sortByTimestampDesc();
    final List<DeletionHistoryDb> dbs;
    if (limit != null && offset != null) {
      dbs = await query.offset(offset).limit(limit).findAll();
    } else if (limit != null) {
      dbs = await query.limit(limit).findAll();
    } else if (offset != null) {
      dbs = await query.offset(offset).findAll();
    } else {
      dbs = await query.findAll();
    }
    return dbs.map(DeletionHistory.fromDb).toList();
  }

  Future<void> _persistProfile(UserProfile profile) async {
    final user = _client.auth.currentUser;

    // Always persist to local first with pending status
    final localProfile = profile.copyWith(
      syncStatus: SyncStatus.pendingUpdate,
      updatedAt: DateTime.now(),
    );
    await _persistLocalOnly(localProfile);

    if (user != null) {
      try {
        await _client
            .from('user_profiles')
            .update(localProfile.toJson())
            .eq('id', user.id);

        // Mark as synced on success
        final syncedProfile = localProfile.copyWith(
          syncStatus: SyncStatus.synced,
        );
        await _persistLocalOnly(syncedProfile);
      } catch (e) {
        debugPrint('Error persisting profile to Supabase: $e');
        // Keep as pendingUpdate — SyncService will retry later
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
