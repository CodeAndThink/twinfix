import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';

class ActivityDetailNavigator extends BaseNavigator {
  const ActivityDetailNavigator(super.context);

  void goToHistory() {
    pushNamed(AppRouter.history);
  }
}
