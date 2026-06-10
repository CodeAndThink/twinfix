import 'package:go_router/go_router.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class ResetPasswordNavigator extends BaseNavigator {
  ResetPasswordNavigator(super.context);

  void goToHome() {
    context.goNamed(AppRouter.scan);
  }
}
