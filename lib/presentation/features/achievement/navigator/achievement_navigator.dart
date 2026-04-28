import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/features/badge_gallery/page/badge_gallery_page.dart';

import 'package:twinfix/presentation/features/badge_detail/pages/badge_detail_page.dart';

import '../../../../core/navigation/base_navigator.dart';

class AchievementNavigator extends BaseNavigator {
  const AchievementNavigator(super.context);

  void openBadgeGallery({required BadgeGalleryPageArgs args}) {
    pushNamed(AppRouter.badgeGallery, extra: args);
  }

  void openBadgeDetail({required BadgeDetailPageArgs args}) {
    pushNamed(AppRouter.badgeDetail, extra: args);
  }

  void openActivityDetail() {
    pushNamed(AppRouter.activityDetail);
  }
}
