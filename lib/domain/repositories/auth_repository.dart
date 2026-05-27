import 'dart:async';
import 'package:twinfix/domain/params/update_profile_params.dart';

import '../entities/user_profile.dart';
import '../entities/deletion_history.dart';

/// Result of a cleanup session, including the updated profile and newly earned badges
class DeletionResult {
  final UserProfile updatedProfile;
  final List<String> newBadgeIds;

  const DeletionResult({
    required this.updatedProfile,
    this.newBadgeIds = const [],
  });
}

class UnsyncedDataException implements Exception {
  final String message;
  UnsyncedDataException([
    this.message = 'There is some data that is out of sync.',
  ]);
}

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> forgotPassword({required String email});
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> signInWithGoogle();
  Future<void> logout({bool force = false});
  bool get isAuthenticated;
  Future<bool> hasUnsyncedData();
  Future<void> updateProfile({required UpdateProfileParams params});

  /// Monitor changes to the User Profile
  Stream<UserProfile> watchUserProfile();

  /// Get current user profile (from remote)
  Future<UserProfile> getUserProfile();

  /// Get current user profile (from local cache)
  Future<UserProfile?> getCachedProfile();

  /// Record a photo deletion session and automatically evaluate achievements.
  /// [totalCount]: Total number of items deleted
  /// [totalDeletedSize]: Total released storage size (bytes)
  /// [blurryCount]: Number of blurry photos deleted
  /// [duplicateCount]: Number of duplicate photos deleted
  Future<DeletionResult> recordDeletion({
    required int totalCount,
    required int totalDeletedSize,
    int blurryCount = 0,
    int duplicateCount = 0,
  });

  /// Sync guest profile data to the new account
  Future<void> syncGuestProfile(bool shouldMerge);

  /// Save deletion history
  Future<void> saveDeletionHistory(DeletionHistory history);

  /// Get all deletion history, sorted by newest first
  Future<List<DeletionHistory>> getDeletionHistory();

  /// Update Pro status (subscription) to Supabase
  Future<void> updateProStatus({required bool isPro});
}
