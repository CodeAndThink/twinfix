import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/features/achievement/cubit/achievement_state.dart';
import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement/pages/achievement_loading_page.dart';
import 'package:twinfix/presentation/features/achievement/widgets/badge_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

import '../../../../core/di/injection.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../domain/entities/badge_item.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../../../widgets/user/user_level_progress_card.dart';
import '../cubit/achievement_cubit.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementCubit(
        userRepository: locator(),
        globalAppCubit: locator(),
        navigator: AchievementNavigator(context),
      ),
      child: const AchievementChildPage(),
    );
  }
}

class AchievementChildPage extends StatefulWidget {
  const AchievementChildPage({super.key});

  @override
  State<AchievementChildPage> createState() => _AchievementChildPageState();
}

class _AchievementChildPageState extends State<AchievementChildPage> {
  late AchievementCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AchievementCubit>();
    _cubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.tabDashboard,
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AchievementCubit, AchievementState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.profile != current.profile,
      builder: (context, state) {
        if (state.status.isLoading) {
          return const AchievementLoadingPage();
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

        final padding = MediaQuery.of(context).padding;

        if (state.status.isSuccess && state.profile != null) {
          final profile = state.profile!;
          return RefreshIndicator(
            onRefresh: _cubit.loadProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: padding.top + 12,
                left: 12,
                right: 12,
                bottom: padding.bottom + 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroductionWidget(),
                  // Memory Warning based on actual storage
                  _buildMemoryWarning(),
                  _buildSectionHeader(
                    title: _l10n.progress,
                    color: _theme.colorScheme.primary,
                  ),
                  // Level Header
                  UserLevelProgressCard(profile: profile),

                  // Stats Row
                  _buildSectionHeader(
                    title: _l10n.stats,
                    color: _theme.colorScheme.primary,
                  ),
                  _buildStatsRow(profile: profile),

                  // Badges Section
                  _buildSectionHeader(
                    title: _l10n.badges,
                    color: _theme.colorScheme.primary,
                  ),
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

  Widget _buildIntroductionWidget() {
    return Container(
      width: double.infinity,
      padding: 12.paddingAll,
      decoration: BoxDecoration(
        borderRadius: 28.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_theme.colorScheme.primary, _theme.colorScheme.secondary],
        ),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
      ),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: 16.borderRadius,
              child: AppAssetImage(
                path: AppAssets.icCrocodile2,
                width: 120,
                height: 120,
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _l10n.tabDashboard,
                    style: _theme.textTheme.titleLarge?.copyWith(
                      color: _theme.colorScheme.onPrimary,
                    ),
                  ),
                  4.height,
                  Text(
                    _l10n.progress,
                    style: _theme.textTheme.bodyLarge?.copyWith(
                      color: _theme.colorScheme.primaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _l10n.cleanedData,
                    style: _theme.textTheme.bodySmall?.copyWith(
                      color: _theme.colorScheme.surfaceDim,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, Color? color}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: _theme.textTheme.titleMedium?.copyWith(
            color: color ?? _theme.colorScheme.primary,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryWarning() {
    return BlocBuilder<AchievementCubit, AchievementState>(
      buildWhen: (previous, current) =>
          previous.storageUsagePercent != current.storageUsagePercent,
      builder: (context, state) {
        if (state.storageUsagePercent < 85) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: AppTransparentContainer(
            color: _theme.colorScheme.errorContainer.withValues(alpha: 0.1),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 32,
                    color: _theme.colorScheme.error,
                  ),
                ),
                16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _l10n.memoryWarning,
                        style: _theme.textTheme.titleMedium?.copyWith(
                          color: _theme.colorScheme.error,
                        ),
                      ),
                      4.height,
                      Text(
                        _l10n.storageAlmostFull(
                          state.storageUsagePercent.toInt(),
                        ),
                        style: _theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsRow({required UserProfile profile}) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_fire_department,
            color: Colors.redAccent,
            value: _l10n.streakDays(profile.streakDays),
            label: _l10n.streaks,
          ),
        ),
        12.width,
        Expanded(
          child: _buildStatCard(
            icon: Icons.cleaning_services,
            color: Colors.green,
            value: _l10n.totalPhotos(profile.totalDeletedPhotos),
            label: _l10n.itemsDeleted,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return AppTransparentContainer(
      padding: 12.padding,
      child: Column(
        children: [
          Icon(icon, color: color, size: 36),
          6.height,
          Text(
            value,
            style: _theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          4.height,
          Text(
            label.toUpperCase(),
            style: _theme.textTheme.labelSmall?.copyWith(
              color: color,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection({required UserProfile profile}) {
    List<String> earnedBadges = profile.badgeIds;

    return SizedBox(
      width: double.infinity,
      child: AppTransparentContainer(
        padding: 12.padding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final itemWidth = maxWidth / 4;
            return Wrap(
              children: List.generate(AppBadges.allBadges.length, (index) {
                final badge = AppBadges.allBadges[index];
                final isEarned = earnedBadges.contains(badge.id);

                return SizedBox(
                  width: itemWidth,
                  child: BadgeListItem(
                    badgeId: badge.id,
                    badge: badge,
                    isEarned: isEarned,
                    onTap: () => _cubit.openAchievementDetail(
                      badge: badge,
                      isEarned: isEarned,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
