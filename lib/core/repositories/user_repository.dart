import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_profile.dart';
import '../services/auth_service.dart';

@lazySingleton
class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final AuthService authService;

  UserRepository({required this.authService});

  /// Lấy thông tin user hiện tại (fake data nếu Supabase chưa cấu hình đúng)
  Future<UserProfile> getUserProfile() async {
    final user = authService.currentUser;
    if (user == null) {
      // Chưa đăng nhập (kể cả anon), trả về default
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
        // Tạo profile mới nếu chưa có
        final newProfile = UserProfile(id: user.id);
        await _client.from('user_profiles').insert(newProfile.toJson());
        return newProfile;
      }
    } catch (e) {
      debugPrint('Supabase error, returning local mock data: $e');
      // Trả về mock data cho UI test nếu DB chưa thiết lập
      return UserProfile(
        id: user.id,
        totalCleanedBytes: 850 * 1024 * 1024, // 850MB -> Level 2
        streakDays: 3,
        badgeIds: const ['newbie'],
        isPro: true, // Mock bật Pro tính năng quét sâu
      );
    }
  }

  /// Cập nhật dung lượng bộ nhớ đã dọn
  Future<void> addCleanedBytes(int bytes) async {
    final user = authService.currentUser;
    if (user == null) return;

    try {
      // Gọi RPC hoặc query đơn giản (cần backend hỗ trợ an toàn hơn, hiện tại update thẳng)
      final profile = await getUserProfile();
      final newTotal = profile.totalCleanedBytes + bytes;

      await _client
          .from('user_profiles')
          .update({'total_cleaned_bytes': newTotal})
          .eq('id', user.id);
    } catch (e) {
      debugPrint('Error updating cleaned bytes: $e');
    }
  }
}
