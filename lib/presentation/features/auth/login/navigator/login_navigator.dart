import 'package:twinfix/core/navigation/base_navigator.dart';

class LoginNavigator extends BaseNavigator {
  LoginNavigator(super.context);

  void goToRegister() {
    push('/register');
  }

  void goToForgotPassword() {
    push('/forgot-password');
  }
}
