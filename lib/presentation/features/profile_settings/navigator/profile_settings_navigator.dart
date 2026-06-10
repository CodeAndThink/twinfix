import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class ProfileSettingsNavigator extends BaseNavigator {
  ProfileSettingsNavigator(super.context);

  void goToDeleteAccountWarning() {
    pushNamed(AppRouter.deleteAccount);
  }

  void goToChangePassword() {
    pushNamed(AppRouter.changePassword);
  }
}
