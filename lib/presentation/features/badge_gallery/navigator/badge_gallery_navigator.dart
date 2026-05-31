import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/presentation/features/badge_detail/pages/badge_detail_page.dart';

class BadgeGalleryNavigator extends BaseNavigator {
  const BadgeGalleryNavigator(super.context);

  void openBadgeDetail({required BadgeDetailPageArgs args}) {
    pushNamed(AppRouter.badgeDetail, extra: args);
  }
}
