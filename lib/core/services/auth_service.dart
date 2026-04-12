import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@singleton
class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  AuthService();

  User? get currentUser => _client.auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  /// Đăng nhập ẩn danh đẻ lưu trữ điểm số cục bộ trên database mà không cần email
  Future<void> signInAnonymously() async {
    try {
      if (!isAuthenticated) {
        await _client.auth.signInAnonymously();
      }
    } catch (e) {
      // In production, we might want to log this properly or throw a custom AppFailure
      debugPrint('Failed to sign in anonymously: $e');
    }
  }

  /// Thoát tài khoản (có thể không dùng nếu chỉ luôn chơi ẩn danh)
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
