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
      debugPrint('Failed to sign in anonymously: $e');
    }
  }

  /// Giả lập đăng nhập bằng Email/Social (Sử dụng login email thật của Supabase)
  Future<void> signInWithMockAccount() async {
    try {
      // Vì là môi trường dev/demo, tôi sẽ dùng một email mẫu
      // Trong thực tế sẽ gọi GoogleSignIn hoặc hiện form nhập email
      await _client.auth.signInWithOtp(email: 'demo-user@twinfix.app');
      debugPrint('Mock login initiated via OTP');
    } catch (e) {
      debugPrint('Failed to mock sign in: $e');
    }
  }

  /// Thoát tài khoản
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
