import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator(super.context);

  void toOnboarding() {
    goNamed(AppRouter.onboarding);
  }

  void toScan() {
    goNamed(AppRouter.scan);
  }
}
