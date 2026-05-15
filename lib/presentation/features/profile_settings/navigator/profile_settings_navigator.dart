import 'package:twinfix/core/navigation/base_navigator.dart';

class ProfileSettingsNavigator extends BaseNavigator {
  ProfileSettingsNavigator(super.context);

  void goToChangePassword() {
    // Navigate to change password page if implemented
    // For now, we can show a message or just a placeholder
    flushBar.showInfo(message: 'Feature coming soon!');
  }
}
