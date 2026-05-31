import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/features/scan_result/pages/scan_result_page.dart';
import '../../../../core/navigation/base_navigator.dart';

class ScanLoadingNavigator extends BaseNavigator {
  const ScanLoadingNavigator(super.context);

  void replaceWithScanResult(ScanResultPageArgs args) {
    replaceNamed(AppRouter.scanResult, extra: args);
  }
}
