import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/data/models/sync_strategy.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/core/services/sync_service.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'app_state.dart';

@lazySingleton
class AppCubit extends BaseCubit<AppState> {
  final AuthRepository _authRepository;
  final IapService _iapService;
  final SubscriptionCubit _subscriptionCubit;
  final SyncService _syncService;
  StreamSubscription<AuthState>? _authSubscription;

  AppCubit(
    this._authRepository,
    this._iapService,
    this._subscriptionCubit,
    this._syncService,
  ) : super(const AppState()) {
    _init();
  }

  void _init() {
    // Start background sync service (listens to connectivity changes)
    _syncService.init();

    // Listen to authentication state changes from Supabase
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

  Future<void> syncLocalData(SyncStrategy strategy) async {
    safeEmit(state.copyWith(syncStatus: LoadStatus.loading));

    try {
      await _authRepository.syncGuestProfile(strategy);
      await fetchProfile();
      safeEmit(state.copyWith(syncStatus: LoadStatus.success));
    } catch (e) {
      safeEmit(state.copyWith(syncStatus: LoadStatus.failure));
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

  Future<void> _onUnauthenticated() async {
    await _iapService.logOut();

    // Refresh SubscriptionCubit state so UI reflects the new anonymous user (no premium)
    await _subscriptionCubit.refreshStatus();

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
    safeEmit(state.copyWith(loginStatus: LoadStatus.loading));
    try {
      await _authRepository.login(email: email, password: password);
      // _onAuthenticated will be called from the stream listener
    } catch (e) {
      safeEmit(state.copyWith(loginStatus: LoadStatus.failure));
      rethrow;
    }
  }

  Future<void> signOut() async {
    safeEmit(state.copyWith(logoutStatus: LoadStatus.loading));
    try {
      await _authRepository.logout();
    } catch (e) {
      safeEmit(state.copyWith(logoutStatus: LoadStatus.failure));
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _syncService.dispose();
    return super.close();
  }
}
