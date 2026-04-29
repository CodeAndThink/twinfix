import 'dart:async';
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
  Future<void> logout();
  bool get isAuthenticated;

  /// Theo dõi sự thay đổi của User Profile
  Stream<UserProfile> watchUserProfile();

  /// Lấy thông tin user hiện tại
  Future<UserProfile> getUserProfile();

  /// Ghi nhận một phiên xóa ảnh và tự động đánh giá achievement.
  Future<DeletionResult> recordDeletion({
    required int totalCount,
    int blurryCount = 0,
    int duplicateCount = 0,
  });

  /// Cập nhật dung lượng bộ nhớ đã dọn
  Future<UserProfile> addCleanedBytes(int bytes);

  /// Đồng bộ dữ liệu từ Guest sang Account mới
  Future<void> syncGuestProfile(bool shouldMerge);

  /// Lưu lịch sử xóa
  Future<void> saveDeletionHistory(DeletionHistory history);

  /// Lấy toàn bộ lịch sử xóa, sắp xếp theo thời gian mới nhất
  Future<List<DeletionHistory>> getDeletionHistory();
}
