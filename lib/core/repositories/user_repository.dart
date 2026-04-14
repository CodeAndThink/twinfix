import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/data/models/user_profile_db.dart';
import '../../domain/entities/user_profile.dart';
import '../services/auth_service.dart';

@lazySingleton
class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService authService;
  final Isar isar;

  UserRepository({required this.authService, required this.isar});

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

  /// Cập nhật dung lượng bộ nhớ đã dọn
  Future<UserProfile> addCleanedBytes(int bytes) async {
    final user = authService.currentUser;
    final profile = await getUserProfile();
    final newTotal = profile.totalCleanedBytes + bytes;

    if (user == null) {
      // Chế độ khách: Cập nhật Isar
      final dbItem = profile.copyWith(totalCleanedBytes: newTotal).toDb();
      await isar.writeTxn(() => isar.userProfileDbs.put(dbItem));
      return UserProfile.fromDb(dbItem);
    }

    try {
      await _client
          .from('user_profiles')
          .update({'total_cleaned_bytes': newTotal})
          .eq('id', user.id);

      return profile.copyWith(totalCleanedBytes: newTotal);
    } catch (e) {
      debugPrint('Error updating cleaned bytes: $e');
      rethrow;
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

      // Hợp nhất BadgeIds (Unique)
      final mergedBadges =
          (remoteProfile.badgeIds.toSet()..addAll(localProfile.badgeIds))
              .toList();

      await _client
          .from('user_profiles')
          .update({
            'total_cleaned_bytes': mergedBytes,
            'badge_ids': mergedBadges,
          })
          .eq('id', user.id);
    }

    // Sau khi xử lý (merge hoặc bỏ qua), xóa dữ liệu guest
    await isar.writeTxn(() => isar.userProfileDbs.delete(0));
  }
}
