import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'subscription_state.dart';

@lazySingleton
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final IapService _iapService;

  SubscriptionCubit(this._iapService) : super(const SubscriptionState());

  Future<void> init() async {
    emit(state.copyWith(initStatus: LoadStatus.loading));
    await _iapService.init();

    final isPremium = await _iapService.checkPremium();
    final packages = await _iapService.getOfferings();

    emit(
      state.copyWith(
        isPremium: isPremium,
        packages: packages,
        initStatus: LoadStatus.success,
      ),
    );
  }

  Future<void> purchase(Package package) async {
    emit(state.copyWith(purchaseStatus: LoadStatus.loading));
    final success = await _iapService.purchasePackage(package);
    if (success) {
      emit(state.copyWith(isPremium: true, purchaseStatus: LoadStatus.success));
    } else {
      emit(
        state.copyWith(
          purchaseStatus: LoadStatus.failure,
          errorMessage: "Mua hàng thất bại hoặc bị hủy.",
        ),
      );
    }
  }

  Future<void> restore() async {
    emit(state.copyWith(restoreStatus: LoadStatus.loading));
    final success = await _iapService.restorePurchases();
    if (success) {
      emit(state.copyWith(isPremium: true, restoreStatus: LoadStatus.success));
    } else {
      emit(
        state.copyWith(
          restoreStatus: LoadStatus.failure,
          errorMessage:
              "Không tìm thấy giao dịch nào để khôi phục hoặc bạn chưa đăng ký.",
        ),
      );
    }
  }
}
