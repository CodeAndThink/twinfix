import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/features/paywall/navigator/paywall_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/presentation/features/paywall/cubit/paywall_state.dart';

class PaywallCubit extends BaseCubit<PaywallState> {
  final PaywallNavigator navigator;
  final SubscriptionCubit subscriptionCubit;

  PaywallCubit({required this.navigator, required this.subscriptionCubit})
    : super(const PaywallState());

  void onMonthPurchasePress() {
    if (subscriptionCubit.state.monthlyPackage != null) {
      subscriptionCubit.purchase(
        package: subscriptionCubit.state.monthlyPackage!,
      );
    } else {
      navigator.flushBar.showError(
        message: S.current.purchaseErrorStoreConnection,
      );
    }
  }

  void onLifeTimePurchasePress() {
    if (subscriptionCubit.state.lifetimePackage != null) {
      subscriptionCubit.purchase(
        package: subscriptionCubit.state.lifetimePackage!,
      );
    } else {
      navigator.flushBar.showError(
        message: S.current.purchaseErrorStoreConnection,
      );
    }
  }
}
