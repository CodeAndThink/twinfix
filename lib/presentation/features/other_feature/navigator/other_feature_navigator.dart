import 'package:twinfix/core/navigation/base_navigator.dart';

import 'package:go_router/go_router.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/features/scan_result/pages/scan_result_page.dart';

class OtherFeatureNavigator extends BaseNavigator {
  OtherFeatureNavigator(super.context);

  void navigateToDuplicatePhotos(List<MediaItem> items) {
    context.pushNamed(
      AppRouter.scanResult,
      extra: ScanResultPageArgs(initialDuplicates: items),
    );
  }

  void navigateToBlurryPhotos(List<MediaItem> items) {
    context.pushNamed(
      AppRouter.scanResult,
      extra: ScanResultPageArgs(initialDuplicates: items),
    );
  }
}
