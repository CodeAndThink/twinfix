import 'dart:io';

import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/achievement_detail/pages/achievement_detail_page.dart';
import 'package:twinfix/presentation/features/dashboard/cubit/dashboard_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/repositories/user_repository.dart';
import '../navigator/dashboard_navigator.dart';

class DashboardCubit extends BaseCubit<DashboardState> {
  final UserRepository userRepository;
  final AppCubit globalAppCubit;
  final DashboardNavigator navigator;

  DashboardCubit({
    required this.userRepository,
    required this.globalAppCubit,
    required this.navigator,
  }) : super(DashboardState.initial());

  Future<void> loadProfile() async {
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final profile = await userRepository.getUserProfile();
      final storagePercent = await _getStorageUsagePercent();

      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          profile: profile,
          storageUsagePercent: storagePercent,
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<double> _getStorageUsagePercent() async {
    try {
      if (Platform.isAndroid) {
        // Simple mock for demo, in real앱 would use storage_space or similar
        return 75.0;
      } else if (Platform.isIOS) {
        return 65.0;
      }
      return 50.0;
    } catch (e) {
      return 0.0;
    }
  }

  void openAchievementDetail({
    required BadgeItem badge,
    required bool isEarned,
  }) {
    navigator.openAchievementDetail(
      args: AchievementDetailPageArgs(badge: badge, isEarned: isEarned),
    );
  }
}
