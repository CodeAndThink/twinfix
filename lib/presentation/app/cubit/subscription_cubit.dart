import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'subscription_state.dart';

@lazySingleton
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final IapService _iapService;
  final AuthRepository _authRepository;

  SubscriptionCubit(this._iapService, this._authRepository)
    : super(const SubscriptionState());

  Future<void> init() async {
    emit(state.copyWith(initStatus: LoadStatus.loading));
    await _iapService.init();

    final isPremium = await _iapService.checkPremium();
    final activeProductIdentifiers = await _iapService
        .getActiveProductIdentifiers();
    final packages = await _iapService.getOfferings();

    // Sync pro status to Supabase on every app launch
    // Handles refund/expiration: if RevenueCat says not premium → is_pro = false
    await _authRepository.updateProStatus(isPro: isPremium);

    emit(
      state.copyWith(
        isPremium: isPremium,
        activeProductIdentifiers: activeProductIdentifiers,
        packages: packages,
        initStatus: LoadStatus.success,
      ),
    );
  }

  Future<void> purchase({required Package package}) async {
    emit(state.copyWith(purchaseStatus: LoadStatus.loading));
    final success = await _iapService.purchasePackage(package: package);
    if (success) {
      final activeProductIdentifiers = await _iapService
          .getActiveProductIdentifiers();
      emit(
        state.copyWith(
          isPremium: true,
          activeProductIdentifiers: activeProductIdentifiers,
          purchaseStatus: LoadStatus.success,
        ),
      );

      // Sync pro status to Supabase
      await _authRepository.updateProStatus(isPro: true);
    } else {
      emit(
        state.copyWith(
          purchaseStatus: LoadStatus.failure,
          errorMessage: S.current.purchaseFailureMessage,
        ),
      );
    }
  }

  Future<void> restore() async {
    emit(state.copyWith(restoreStatus: LoadStatus.loading));
    final success = await _iapService.restorePurchases();
    if (success) {
      final activeProductIdentifiers = await _iapService
          .getActiveProductIdentifiers();
      emit(
        state.copyWith(
          isPremium: true,
          activeProductIdentifiers: activeProductIdentifiers,
          restoreStatus: LoadStatus.success,
        ),
      );

      // Sync pro status to Supabase
      await _authRepository.updateProStatus(isPro: true);
    } else {
      emit(
        state.copyWith(
          restoreStatus: LoadStatus.failure,
          errorMessage: S.current.restoreFailureMessage,
        ),
      );
    }
  }
}
