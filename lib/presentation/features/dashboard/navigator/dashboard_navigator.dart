import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/features/achievement_detail/pages/achievement_detail_page.dart';

import '../../../../core/navigation/base_navigator.dart';

class DashboardNavigator extends BaseNavigator {
  const DashboardNavigator(super.context);

  void openAchievementDetail({required AchievementDetailPageArgs args}) {
    pushNamed(AppRouter.achievementDetail, extra: args);
  }
}
