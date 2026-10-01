import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'subscription_state.dart';

@lazySingleton
class SubscriptionCubit extends Cubit<SubscriptionState>
    with WidgetsBindingObserver {
  final IapService _iapService;
  final AuthRepository _authRepository;
  Future<void> _queue = Future.value();
  String? _userId;
  bool _hasIdentity = false;
  bool _observing = false;
  bool _listening = false;
  CustomerInfo? _lastInfo;
  CustomerInfo? _pendingInfo;
  bool _storeBusy = false;
  bool _refreshQueued = false;
  int _generation = 0;
  int _running = 0;

  SubscriptionCubit(this._iapService, this._authRepository)
    : super(const SubscriptionState());

  bool _current(int generation) => !isClosed && generation == _generation;

  Future<void> _enqueue(Future<void> Function() action) {
    final next = _queue.then((_) async {
      if (isClosed) return;
      _running++;
      try {
        await action();
      } finally {
        _running--;
        _drainCustomerUpdate();
      }
    });
    _queue = next.catchError((Object error, StackTrace stack) {
      debugPrint('Subscription operation failed: $error');
    });
    return _queue;
  }

  /// Auth changes invalidate old results immediately, even while a store sheet
  /// is open. The next identity change waits until that operation finishes.
  Future<void> setUser(String? userId) {
    if (isClosed) return Future.value();
    if (!_observing) {
      _observing = true;
      WidgetsBinding.instance.addObserver(this);
    }
    final changed = !_hasIdentity || _userId != userId;
    if (changed) {
      _hasIdentity = true;
      _userId = userId;
      _generation++;
      _lastInfo = null;
      _pendingInfo = null;
      emit(const SubscriptionState(initStatus: LoadStatus.loading));
    }
    final generation = _generation;
    return _enqueue(() async {
      if (!_current(generation)) return;
      await _load(
        generation,
        loadOfferings: changed || !state.initStatus.isSuccess,
      );
    });
  }

  /// Retry initialization/offerings for the current identity.
  Future<void> init() {
    if (!_hasIdentity) return setUser(null);
    final generation = _generation;
    return _enqueue(() async {
      if (_current(generation)) await _load(generation, loadOfferings: true);
    });
  }

  Future<void> _load(int generation, {required bool loadOfferings}) async {
    emit(
      state.copyWith(
        refreshStatus: LoadStatus.loading,
        initStatus: loadOfferings ? LoadStatus.loading : null,
      ),
    );
    try {
      final info = await _iapService.syncUser(_userId);
      if (!_current(generation)) return;
      _apply(info);
      if (!_listening) {
        _listening = true;
        _iapService.addCustomerInfoListener(_onCustomerInfo);
      }
      // Apply access before loading products: a store outage must not revoke it.
      if (loadOfferings) {
        try {
          final packages = await _iapService.getOfferings();
          if (!_current(generation)) return;
          emit(
            state.copyWith(
              packages: packages,
              initStatus: packages.isEmpty
                  ? LoadStatus.failure
                  : LoadStatus.success,
            ),
          );
        } catch (e) {
          if (!_current(generation)) return;
          emit(state.copyWith(initStatus: LoadStatus.failure));
          debugPrint('Could not load store offerings: $e');
        }
      }
      if (!_current(generation)) return;
      emit(state.copyWith(refreshStatus: LoadStatus.success));
      await _syncProfile(info, generation);
    } catch (e) {
      if (!_current(generation)) return;
      emit(
        state.copyWith(
          refreshStatus: LoadStatus.failure,
          initStatus: loadOfferings ? LoadStatus.failure : null,
        ),
      );
      debugPrint('Could not refresh subscription: $e');
    }
  }

  void _apply(CustomerInfo info) {
    _lastInfo = info;
    if (_sameAccess(_pendingInfo, info)) _pendingInfo = null;
    emit(
      state.copyWith(
        isReady: true,
        isPremium: IapService.hasPremium(info),
        activeProductIdentifiers: IapService.activeProductIdentifiers(info),
      ),
    );
  }

  Future<void> _syncProfile(CustomerInfo info, int generation) async {
    if (!_current(generation)) return;
    try {
      await _authRepository.updateProStatus(
        isPro: IapService.hasPremium(info),
        userId: _userId,
      );
    } catch (e) {
      // The store result is authoritative for local access. Retry the profile
      // mirror on the next refresh; never turn a completed purchase into failure.
      debugPrint('Could not mirror subscription status: $e');
    }
  }

  Future<void> refreshStatus() async {
    if (!_hasIdentity || _refreshQueued || isClosed) return;
    _refreshQueued = true;
    final generation = _generation;
    try {
      await _enqueue(() async {
        if (_current(generation)) {
          await _load(generation, loadOfferings: !state.initStatus.isSuccess);
        }
      });
    } finally {
      _refreshQueued = false;
      _drainCustomerUpdate();
    }
  }

  bool _sameAccess(CustomerInfo? a, CustomerInfo? b) =>
      a != null &&
      b != null &&
      a.entitlements == b.entitlements &&
      listEquals(a.activeSubscriptions, b.activeSubscriptions);

  void _onCustomerInfo(CustomerInfo info) {
    // Treat callbacks as invalidation signals, not as proof of user identity.
    // Ignore requestDate changes so our own reads cannot cause a refresh loop.
    if (_sameAccess(info, _lastInfo)) return;
    _pendingInfo = info;
    _drainCustomerUpdate();
  }

  void _drainCustomerUpdate() {
    if (isClosed || _running != 0 || _refreshQueued || _pendingInfo == null) {
      return;
    }
    _pendingInfo = null;
    unawaited(refreshStatus());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(refreshStatus());
  }

  void resetOperationStatus() {
    if (isClosed || _storeBusy) return;
    emit(
      state.copyWith(
        purchaseStatus: LoadStatus.initial,
        restoreStatus: LoadStatus.initial,
        clearPurchaseOutcome: true,
      ),
    );
  }

  Future<void> purchase({required Package package}) =>
      _storeOperation(package: package);

  Future<void> restore() => _storeOperation();

  Future<void> _storeOperation({Package? package}) async {
    if (_storeBusy || !state.isReady || isClosed) return;
    _storeBusy = true;
    final generation = _generation;
    final restoring = package == null;
    emit(
      state.copyWith(
        purchaseStatus: restoring ? LoadStatus.initial : LoadStatus.loading,
        restoreStatus: restoring ? LoadStatus.loading : LoadStatus.initial,
        clearPurchaseOutcome: true,
      ),
    );
    try {
      await _enqueue(() async {
        if (!_current(generation)) return;
        try {
          final CustomerInfo? info;
          final PurchaseOutcome outcome;
          if (restoring) {
            info = await _iapService.restorePurchases();
            outcome = IapService.hasPremium(info)
                ? PurchaseOutcome.success
                : PurchaseOutcome.failure;
          } else {
            final result = await _iapService.purchasePackage(package: package);
            info = result.customerInfo;
            outcome = result.outcome;
          }
          if (!_current(generation)) return;
          if (info != null) _apply(info);
          final status = switch (outcome) {
            PurchaseOutcome.success => LoadStatus.success,
            PurchaseOutcome.failure => LoadStatus.failure,
            PurchaseOutcome.cancelled ||
            PurchaseOutcome.pending => LoadStatus.initial,
          };
          emit(
            state.copyWith(
              purchaseStatus: restoring ? LoadStatus.initial : status,
              restoreStatus: restoring ? status : LoadStatus.initial,
              purchaseOutcome: restoring ? null : outcome,
            ),
          );
          if (info != null) await _syncProfile(info, generation);
        } catch (e) {
          if (!_current(generation)) return;
          emit(
            state.copyWith(
              purchaseStatus: restoring
                  ? LoadStatus.initial
                  : LoadStatus.failure,
              restoreStatus: restoring
                  ? LoadStatus.failure
                  : LoadStatus.initial,
              purchaseOutcome: restoring ? null : PurchaseOutcome.failure,
            ),
          );
          debugPrint('Store operation failed: $e');
        }
      });
    } finally {
      _storeBusy = false;
    }
  }

  @override
  Future<void> close() {
    _generation++;
    if (_observing) {
      WidgetsBinding.instance.removeObserver(this);
    }
    if (_listening) _iapService.removeCustomerInfoListener(_onCustomerInfo);
    return super.close();
  }
}
