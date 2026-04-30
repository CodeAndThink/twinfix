import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'subscription_state.dart';

@lazySingleton
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final IapService _iapService;

  SubscriptionCubit(this._iapService) : super(const SubscriptionState());

  Future<void> init() async {
    emit(state.copyWith(status: SubscriptionStatus.loading));
    await _iapService.init();

    final isPremium = await _iapService.checkPremium();
    final packages = await _iapService.getOfferings();

    emit(
      state.copyWith(
        isPremium: isPremium,
        packages: packages,
        status: SubscriptionStatus.loaded,
      ),
    );
  }

  Future<void> purchase(Package package) async {
    emit(state.copyWith(status: SubscriptionStatus.purchasing));
    final success = await _iapService.purchasePackage(package);
    if (success) {
      emit(state.copyWith(isPremium: true, status: SubscriptionStatus.success));
    } else {
      emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage: "Mua hàng thất bại hoặc bị hủy.",
        ),
      );
    }
    // Trở về trạng thái loaded để UI không bị lock
    emit(state.copyWith(status: SubscriptionStatus.loaded));
  }

  Future<void> restore() async {
    emit(state.copyWith(status: SubscriptionStatus.loading));
    final success = await _iapService.restorePurchases();
    if (success) {
      emit(state.copyWith(isPremium: true, status: SubscriptionStatus.success));
    } else {
      emit(
        state.copyWith(
          status: SubscriptionStatus.error,
          errorMessage:
              "Không tìm thấy giao dịch nào để khôi phục hoặc bạn chưa đăng ký.",
        ),
      );
    }
    emit(state.copyWith(status: SubscriptionStatus.loaded));
  }
}
