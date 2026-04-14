import 'package:injectable/injectable.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/core/services/auth_service.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'app_state.dart';

@lazySingleton
class AppCubit extends BaseCubit<AppState> {
  final AuthService _authService;
  final UserRepository _userRepository;

  AppCubit(this._authService, this._userRepository) : super(AppInitial()) {
    _init();
  }

  Future<void> _init() async {
    final user = _authService.currentUser;
    if (user != null) {
      safeEmit(Authenticated(user.id, email: user.email));
    } else {
      safeEmit(Unauthenticated());
    }
  }

  Future<void> login() async {
    // 1. Lưu dấu hiệu đang xử lý đăng nhập
    await _authService.signInWithMockAccount();

    final user = _authService.currentUser;
    if (user != null) {
      // 2. Chuyển sang trạng thái chờ đồng bộ nếu có dữ liệu guest
      final guestProfile = await _userRepository.getUserProfile();
      if (guestProfile.id == 'guest' && guestProfile.totalCleanedBytes > 0) {
        safeEmit(NeedSync(user.id, email: user.email));
      } else {
        safeEmit(Authenticated(user.id, email: user.email));
      }
    }
  }

  Future<void> finalizeSync(bool shouldMerge) async {
    if (state is NeedSync) {
      final s = state as NeedSync;
      await _userRepository.syncGuestProfile(shouldMerge);
      safeEmit(Authenticated(s.userId, email: s.email));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    safeEmit(Unauthenticated());
  }
}
