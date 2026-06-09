import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class DeleteAccountNavigator extends BaseNavigator {
  DeleteAccountNavigator(super.context);

  void goToSettings() {
    goNamed(AppRouter.settings);
  }
}
