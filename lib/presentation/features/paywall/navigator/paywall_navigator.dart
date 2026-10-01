import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/notifications/app_flush_bar.dart';
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

  Future<void> completePurchase({required bool warnAboutMonthly}) async {
    // Display the dialog while the paywall's context is still mounted.
    if (warnAboutMonthly) await dialog.showCancelSubscriptionDialog();
    if (!context.mounted) return;
    final message = S.of(context).purchaseSuccess;
    await dismiss();
    final rootContext = AppRouter.rootNavigatorKey.currentContext;
    if (rootContext != null && rootContext.mounted) {
      AppFlushBar(rootContext).showSuccess(message: message);
    }
  }
}
