import 'package:twinfix/core/navigation/base_navigator.dart';

import 'package:flutter/material.dart';
import 'package:twinfix/presentation/features/change_password/pages/change_password_page.dart';

class ProfileSettingsNavigator extends BaseNavigator {
  ProfileSettingsNavigator(super.context);

  void goToChangePassword() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
  }
}
