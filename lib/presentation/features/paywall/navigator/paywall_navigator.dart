import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class PaywallNavigator extends BaseNavigator {
  const PaywallNavigator(super.context);

  Future<void> dismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenPaywallIntro', true);

    if (isCanPop()) {
      safePop();
    } else {
      goNamed(AppRouter.scan);
    }
  }

  void showCancelSubscriptionDialog() {
    dialog.showCancelSubscriptionDialog();
  }
}
