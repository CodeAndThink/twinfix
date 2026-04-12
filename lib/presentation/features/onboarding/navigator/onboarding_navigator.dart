import 'package:injectable/injectable.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/base_navigator.dart';

@lazySingleton
class OnboardingNavigator extends BaseNavigator {
  OnboardingNavigator()
      : super(AppRouter.router.configuration.navigatorKey.currentContext!);

  void openScan() {
    go('/scan');
  }
}
