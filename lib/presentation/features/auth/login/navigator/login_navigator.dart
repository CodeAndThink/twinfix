import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class LoginNavigator extends BaseNavigator {
  LoginNavigator(super.context);

  void goToRegister() {
    pushNamed(AppRouter.register);
  }

  void goToForgotPassword() {
    pushNamed(AppRouter.forgotPassword);
  }

  void goToSettings() {
    goNamed(AppRouter.settings);
  }
}
