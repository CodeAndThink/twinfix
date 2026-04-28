import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/services/global_services.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/features/achievement/cubit/achievement_state.dart';
import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement/widgets/badge_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/features/achievement/widgets/app_heatmap.dart';

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
        storageRepository: locator(),
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AchievementCubit>();
    _cubit.initData();
    GlobalServices.instance.achievementStream.listen((event) {
      if (_scrollController.hasClients && _scrollController.offset > 0) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else if (_scrollController.hasClients &&
          _scrollController.offset == 0) {
        _cubit.initData();
      }
    });
  }

  @override
  void dispose() {
    GlobalServices.instance.disposeAchievementStream();
    _scrollController.dispose();
    super.dispose();
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
          previous.loadProfileStatus != current.loadProfileStatus ||
          previous.profile != current.profile,
      builder: (context, state) {
        final profile = state.profile;
        return RefreshIndicator(
          onRefresh: () async {
            await _cubit.initData();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 12,
              right: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                // Activity Section
                _buildSectionHeader(
                  title: _l10n.activity,
                  color: _theme.colorScheme.primary,
                ),
                _buildActivityPreview(),
              ],
            ),
          ),
        );
      },
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
          padding: 24.paddingBottom,
          child: AppTransparentContainer(
            borderColor: Colors.red.withValues(alpha: 0.1),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 32,
                    color: Colors.red,
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
                          color: Colors.red,
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

  Widget _buildStatsRow({UserProfile? profile}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _cubit.openActivityDetail(),
            borderRadius: 16.borderRadius,
            child: _buildStatCard(
              icon: Icons.local_fire_department,
              color: Colors.redAccent,
              value: _l10n.streakDays(profile?.streakDays ?? 0),
              label: _l10n.streaks,
            ),
          ),
        ),
        12.width,
        Expanded(
          child: InkWell(
            onTap: () => _cubit.openActivityDetail(),
            borderRadius: 16.borderRadius,
            child: _buildStatCard(
              icon: Icons.cleaning_services,
              color: Colors.green,
              value: _l10n.totalPhotos(profile?.totalDeletedPhotos ?? 0),
              label: _l10n.itemsDeleted,
            ),
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

  Widget _buildBadgesSection({UserProfile? profile}) {
    final earnedBadgeIds = profile?.badgeIds ?? [];

    // Only show badges that the user has earned
    final earnedBadges = AppBadges.allBadges
        .where((badge) => earnedBadgeIds.contains(badge.id))
        .toList();

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 200),
      child: AppTransparentContainer(
        width: double.infinity,
        padding: 12.padding,
        child: Column(
          children: [
            earnedBadges.isNotEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth;
                      final itemWidth = maxWidth / 4;
                      return Wrap(
                        children: List.generate(earnedBadges.length, (index) {
                          final badge = earnedBadges[index];

                          return SizedBox(
                            width: itemWidth,
                            child: BadgeListItem(
                              badgeId: badge.id,
                              badge: badge,
                              onTap: () => _cubit.openBadgeDetail(
                                badge: badge,
                                isEarned: true,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  )
                : SizedBox(
                    height: 138,
                    child: Center(
                      child: Text(
                        _l10n.noBadgesEarnedYet,
                        style: _theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
            8.height,
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: SizedBox(
                height: 30,
                child: InkWell(
                  onTap: () => _cubit.openBadgeGallery(),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _l10n.viewAllBadges,
                          style: _theme.textTheme.bodyMedium?.copyWith(
                            color: _theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        4.width,
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: _theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityPreview() {
    return BlocBuilder<AchievementCubit, AchievementState>(
      buildWhen: (previous, current) =>
          previous.loadHistoryStatus != current.loadHistoryStatus,
      builder: (context, state) {
        return InkWell(
          onTap: () => _cubit.openActivityDetail(),
          child: AppTransparentContainer(
            padding: 12.paddingAll,
            child: Column(
              children: [
                AppHeatMap(history: state.history),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _l10n.viewFullHistory,
                      style: _theme.textTheme.bodyMedium?.copyWith(
                        color: _theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    4.width,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: _theme.colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
