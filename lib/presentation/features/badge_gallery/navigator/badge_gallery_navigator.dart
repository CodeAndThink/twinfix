import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/presentation/features/achievement_detail/pages/achievement_detail_page.dart';

class BadgeGalleryNavigator extends BaseNavigator {
  const BadgeGalleryNavigator(super.context);

  void openAchievementDetail({required AchievementDetailPageArgs args}) {
    pushNamed(AppRouter.achievementDetail, extra: args);
  }
}
