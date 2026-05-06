import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'app_state.dart';

@lazySingleton
class AppCubit extends BaseCubit<AppState> {
  final AuthRepository _authRepository;
  final IapService _iapService;
  final SubscriptionCubit _subscriptionCubit;
  StreamSubscription<AuthState>? _authSubscription;

  AppCubit(this._authRepository, this._iapService, this._subscriptionCubit)
    : super(const AppState()) {
    _init();
  }

  void _init() {
    // Lắng nghe sự thay đổi trạng thái đăng nhập từ Supabase thông qua AuthRepository/Service
    // Ở đây ta có thể dùng trực tiếp Supabase instance hoặc AuthRepository nếu có stream
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      final session = data.session;
      final user = session?.user;

      if (user != null) {
        _onAuthenticated(user);
      } else {
        _onUnauthenticated();
      }
    });
  }

  Future<void> syncLocalData(bool merge) async {
    emit(state.copyWith(syncStatus: LoadStatus.loading));

    try {
      if (merge) {
        // Gọi service để merge dữ liệu local vào database
        // await SyncService.instance.mergeLocalData();
      } else {
        // Gọi service để fetch dữ liệu mới nhất về local
        // await SyncService.instance.fetchLatestData();
      }
      emit(state.copyWith(syncStatus: LoadStatus.success));
    } catch (e) {
      // Handle error
      emit(state.copyWith(syncStatus: LoadStatus.failure));
      rethrow;
    }
  }

  Future<void> _onAuthenticated(User user) async {
    safeEmit(
      state.copyWith(
        userId: user.id,
        email: user.email,
        authStatus: LoadStatus.success,
      ),
    );

    // RevenueCat logIn: merges anonymous purchases → identified user
    await _iapService.logIn(user.id);

    // Refresh SubscriptionCubit state + sync is_pro to Supabase
    await _subscriptionCubit.refreshStatus();

    await fetchProfile();
  }

  void _onUnauthenticated() {
    _iapService.logOut();
    safeEmit(
      const AppState(
        authStatus: LoadStatus.failure,
        userId: '',
        email: null,
        userProfile: null,
      ),
    );
  }

  Future<void> fetchProfile() async {
    try {
      final profile = await _authRepository.getUserProfile();
      safeEmit(state.copyWith(userProfile: profile));
    } catch (e) {
      // Handle error
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(authStatus: LoadStatus.loading));
    try {
      await _authRepository.login(email: email, password: password);
      // _onAuthenticated sẽ được gọi từ stream listener
    } catch (e) {
      emit(state.copyWith(authStatus: LoadStatus.failure));
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    // _onUnauthenticated sẽ được gọi từ stream listener
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
