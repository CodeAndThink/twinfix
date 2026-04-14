import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/features/scan_result/pages/scan_result_page.dart';
import '../../../../core/navigation/base_navigator.dart';

class ScanNavigator extends BaseNavigator {
  const ScanNavigator(super.context);

  void toScanResult({required ScanResultPageArgs args}) {
    pushNamed(AppRouter.scanResult, extra: args);
  }

  void pushMediaTypeSelection() {
    pushNamed(AppRouter.mediaTypeSelection);
  }
}
