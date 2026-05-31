import 'package:twinfix/core/navigation/app_router.dart';
import '../../../../core/navigation/base_navigator.dart';

class ScanNavigator extends BaseNavigator {
  const ScanNavigator(super.context);

  void toScanLoading() {
    pushNamed(AppRouter.scanLoading);
  }

  void pushMediaTypeSelection() {
    pushNamed(AppRouter.mediaTypeSelection);
  }
}
