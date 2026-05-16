import 'dart:async';
import 'package:twinfix/domain/params/update_profile_params.dart';

import '../entities/user_profile.dart';
import '../entities/deletion_history.dart';

/// Kết quả của một phiên dọn dẹp, bao gồm profile mới và badges mới đạt được
class DeletionResult {
  final UserProfile updatedProfile;
  final List<String> newBadgeIds;

  const DeletionResult({
    required this.updatedProfile,
    this.newBadgeIds = const [],
  });
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
  Future<void> logout();
  bool get isAuthenticated;
  Future<void> updateProfile({required UpdateProfileParams params});

  /// Theo dõi sự thay đổi của User Profile
  Stream<UserProfile> watchUserProfile();

  /// Lấy thông tin user hiện tại (từ remote)
  Future<UserProfile> getUserProfile();

  /// Lấy thông tin user hiện tại (từ local cache)
  Future<UserProfile?> getCachedProfile();

  /// Ghi nhận một phiên xóa ảnh và tự động đánh giá achievement.
  /// [totalCount]: Tổng số item đã xóa
  /// [totalDeletedSize]: Tổng dung lượng đã giải phóng (bytes)
  /// [blurryCount]: Số ảnh mờ đã xóa
  /// [duplicateCount]: Số ảnh trùng lặp đã xóa
  Future<DeletionResult> recordDeletion({
    required int totalCount,
    required int totalDeletedSize,
    int blurryCount = 0,
    int duplicateCount = 0,
  });

  /// Đồng bộ dữ liệu từ Guest sang Account mới
  Future<void> syncGuestProfile(bool shouldMerge);

  /// Lưu lịch sử xóa
  Future<void> saveDeletionHistory(DeletionHistory history);

  /// Lấy toàn bộ lịch sử xóa, sắp xếp theo thời gian mới nhất
  Future<List<DeletionHistory>> getDeletionHistory();

  /// Cập nhật trạng thái Pro (subscription) lên Supabase
  Future<void> updateProStatus({required bool isPro});
}
