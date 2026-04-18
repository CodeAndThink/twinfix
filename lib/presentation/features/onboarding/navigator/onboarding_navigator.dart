import 'package:twinfix/core/navigation/app_router.dart';

import '../../../../core/navigation/base_navigator.dart';

class OnboardingNavigator extends BaseNavigator {
  OnboardingNavigator(super.context);

  void toScan() {
    goNamed(AppRouter.scan);
  }
}
