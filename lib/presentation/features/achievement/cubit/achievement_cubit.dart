import 'dart:async';

import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/badge_gallery/page/badge_gallery_page.dart';

import 'package:twinfix/presentation/features/badge_detail/pages/badge_detail_page.dart';
import 'package:twinfix/presentation/features/achievement/cubit/achievement_state.dart';

import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../domain/repositories/storage_repository.dart';
import '../navigator/achievement_navigator.dart';

class AchievementCubit extends BaseCubit<AchievementState> {
  final AuthRepository authRepository;
  final StorageRepository storageRepository;
  final AppCubit globalAppCubit;
  final AchievementNavigator navigator;

  AchievementCubit({
    required this.authRepository,
    required this.storageRepository,
    required this.globalAppCubit,
    required this.navigator,
  }) : super(AchievementState());

  Future<void> initData() async {
    loadProfile();
    _getStorageUsagePercent();
    getDeletionHistory();
  }

  Future<void> loadProfile() async {
    if (state.loadProfileStatus.isLoading) return;
    safeEmit(state.copyWith(loadProfileStatus: LoadStatus.loading));
    try {
      final profile = await authRepository.getUserProfile();

      safeEmit(
        state.copyWith(loadProfileStatus: LoadStatus.success, profile: profile),
      );
    } catch (e) {
      navigator.flushBar.showError(message: e.toString());
      safeEmit(
        state.copyWith(
          loadProfileStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _getStorageUsagePercent() async {
    if (state.loadStorageStatus.isLoading) return;
    safeEmit(state.copyWith(loadStorageStatus: LoadStatus.loading));
    try {
      final storageInfo = await storageRepository.getStorageSpace();

      safeEmit(
        state.copyWith(
          loadStorageStatus: LoadStatus.success,
          storageUsagePercent: storageInfo.usagePercent,
          totalStorage: storageInfo.totalSize,
          freeStorage: storageInfo.freeSize,
        ),
      );
    } catch (e) {
      navigator.flushBar.showError(message: e.toString());
      safeEmit(
        state.copyWith(
          loadStorageStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getDeletionHistory() async {
    if (state.loadHistoryStatus.isLoading) return;
    safeEmit(state.copyWith(loadHistoryStatus: LoadStatus.loading));
    try {
      final history = await authRepository.getDeletionHistory();
      safeEmit(
        state.copyWith(loadHistoryStatus: LoadStatus.success, history: history),
      );
    } catch (e) {
      navigator.flushBar.showError(message: e.toString());
      safeEmit(
        state.copyWith(
          loadHistoryStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void openActivityDetail() {
    navigator.openActivityDetail();
  }

  void openBadgeDetail({required BadgeItem badge, required bool isEarned}) {
    final earnedAt = state.profile?.badgeEarnedDates[badge.id];
    navigator.openBadgeDetail(
      args: BadgeDetailPageArgs(
        badge: badge,
        isEarned: isEarned,
        earnedAt: earnedAt,
      ),
    );
  }

  void openBadgeGallery() {
    navigator.openBadgeGallery(
      args: BadgeGalleryPageArgs(
        ownedBadgeIds: state.profile?.badgeIds ?? [],
        badgeEarnedDates: state.profile?.badgeEarnedDates ?? {},
      ),
    );
  }
}
