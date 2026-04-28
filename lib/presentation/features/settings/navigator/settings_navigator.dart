import 'package:go_router/go_router.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class SettingsNavigator extends BaseNavigator {
  SettingsNavigator(super.context);

  void goToLogin() {
    context.go(AppRouter.login);
  }
}
