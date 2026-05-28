import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class AboutNavigator extends BaseNavigator {
  const AboutNavigator(super.context);

  void goToPrivacy() {
    pushNamed(AppRouter.privacy);
  }

  void goToTermsOfService() {
    pushNamed(AppRouter.termsOfService);
  }

  void goToContact() {
    pushNamed(AppRouter.contact);
  }
}
