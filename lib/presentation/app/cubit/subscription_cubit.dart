import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/generated/l10n.dart';
import 'subscription_state.dart';

@lazySingleton
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final IapService _iapService;

  SubscriptionCubit(this._iapService) : super(const SubscriptionState());

  Future<void> init() async {
    emit(state.copyWith(initStatus: LoadStatus.loading));
    await _iapService.init();

    final isPremium = await _iapService.checkPremium();
    final activeProductIdentifiers = await _iapService
        .getActiveProductIdentifiers();
    final packages = await _iapService.getOfferings();

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
