import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/features/dashboard/cubit/dashboard_state.dart';
import 'package:twinfix/presentation/features/dashboard/navigator/dashboard_navigator.dart';
import 'package:twinfix/presentation/features/dashboard/widgets/badge_list_item.dart';

import '../../../../core/di/injection.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../domain/entities/badge_item.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(
        userRepository: locator(),
        globalAppCubit: locator(),
        navigator: DashboardNavigator(context),
      ),
      child: const DashboardChildPage(),
    );
  }
}

class DashboardChildPage extends StatefulWidget {
  const DashboardChildPage({super.key});

  @override
  State<DashboardChildPage> createState() => _DashboardChildPageState();
}

class _DashboardChildPageState extends State<DashboardChildPage> {
  late DashboardCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DashboardCubit>();
    _cubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.tabDashboard,
      isBack: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.profile != current.profile ||
          previous.storageUsagePercent != current.storageUsagePercent,
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isFailure) {
          return Center(
            child: Text(
              _l10n.error(state.errorMessage ?? ""),
              style: _theme.textTheme.bodyMedium?.copyWith(
                color: _theme.colorScheme.error,
              ),
            ),
          );
        }

        if (state.status.isSuccess && state.profile != null) {
          final profile = state.profile!;
          return RefreshIndicator(
            onRefresh: _cubit.loadProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSizes.s16.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Memory Warning based on actual storage
                  _buildMemoryWarning(state),
                  AppSizes.s24.height,

                  // Level Header
                  _buildLevelCard(profile: profile),
                  AppSizes.s24.height,

                  // Stats Row
                  _buildStatsRow(profile: profile),
                  AppSizes.s24.height,

                  // Badges Section
                  _buildBadgesSection(profile: profile),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMemoryWarning(DashboardState state) {
    // Chỉ hiện cảnh báo nếu dung lượng dùng > 85%
    if (state.storageUsagePercent < 85) return const SizedBox();

    return Container(
      padding: AppSizes.s16.padding,
      decoration: BoxDecoration(
        color: _theme.colorScheme.errorContainer.withValues(alpha: 0.5),
        borderRadius: AppSizes.borderRadius.borderRadius,
        border: Border.all(color: _theme.colorScheme.error),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: _theme.colorScheme.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: _theme.colorScheme.error,
            ),
          ),
          AppSizes.s16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _l10n.memoryWarning,
                  style: _theme.textTheme.titleMedium?.copyWith(
                    color: _theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSizes.s4.height,
                Text(
                  _l10n.storageAlmostFull(state.storageUsagePercent.toInt()),
                  style: _theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard({required UserProfile profile}) {
    return Container(
      padding: AppSizes.s24.padding,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: AppSizes.borderRadius.borderRadius,
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        children: [
          Icon(Icons.stars, size: 48, color: AppColors.primary),
          AppSizes.s8.height,
          Text(
            _l10n.level(profile.currentLevel),
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          AppSizes.s16.height,
          LinearProgressIndicator(
            value: profile.levelProgress,
            backgroundColor: AppColors.placeholderBackground,
            color: AppColors.primary,
            minHeight: 12,
            borderRadius: 10.borderRadius,
          ),
          AppSizes.s8.height,
          Text(
            _l10n.toNextLevel(
              '${(profile.levelProgress * 100).toStringAsFixed(1)}%',
            ),
            style: _theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow({required UserProfile profile}) {
    // Format bytes to MB/GB
    final int bytes = profile.totalCleanedBytes;
    String cleanedStr = AppUtils.formatBytes(bytes);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            Icons.local_fire_department,
            Colors.orange,
            _l10n.streakDays(profile.streakDays),
            'Streaks',
          ),
        ),
        AppSizes.s16.width,
        Expanded(
          child: _buildStatCard(
            context,
            Icons.cleaning_services,
            Colors.blue,
            cleanedStr,
            _l10n.cleanedData,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
    return Container(
      padding: AppSizes.s16.padding,
      decoration: BoxDecoration(
        color: _theme.colorScheme.surface,
        borderRadius: AppSizes.borderRadius.borderRadius,
        boxShadow: [
          BoxShadow(
            color: _theme.brightness == Brightness.light
                ? AppColors.cardShadow
                : Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          AppSizes.s8.height,
          Text(
            value,
            style: _theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          AppSizes.s4.height,
          Text(
            label,
            style: _theme.textTheme.bodySmall?.copyWith(
              color: _theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection({required UserProfile profile}) {
    List<String> earnedBadges = profile.badgeIds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _l10n.badges,
          style: _theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.s16.height,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSizes.s16,
            mainAxisSpacing: AppSizes.s16,
            childAspectRatio: 0.8,
          ),
          itemCount: AppBadges.allBadges.length,
          itemBuilder: (context, index) {
            final badge = AppBadges.allBadges[index];
            final isEarned = earnedBadges.contains(badge.id);

            return BadgeListItem(
              badgeId: badge.id,
              badge: badge,
              isEarned: isEarned,
              onTap: () => _cubit.openAchievementDetail(
                badge: badge,
                isEarned: isEarned,
              ),
            );
          },
        ),
      ],
    );
  }
}
