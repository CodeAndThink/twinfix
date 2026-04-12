import 'package:injectable/injectable.dart';
import 'package:twinfix/core/services/auth_service.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'app_state.dart';

@lazySingleton
class AppCubit extends BaseCubit<AppState> {
  final AuthService _authService;

  AppCubit(this._authService) : super(AppInitial()) {
    _init();
  }

  Future<void> _init() async {
    // Tự động đăng nhập ẩn danh nếu chưa có user
    // await _authService.signInAnonymously();

    final user = _authService.currentUser;
    if (user != null) {
      safeEmit(Authenticated(user.id));
    } else {
      safeEmit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    safeEmit(Unauthenticated());
  }
}
