import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/services/global_services.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';
import 'package:twinfix/presentation/features/achievement/cubit/achievement_state.dart';
import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement/pages/achievement_loading_page.dart';
import 'package:twinfix/presentation/features/achievement/widgets/badge_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/features/achievement/widgets/contributed_graph.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';

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
        authRepository: locator(),
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
          duration: 300.milliseconds,
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
        if (state.loadProfileStatus.isInitial) return AchievementLoadingPage();

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
                AppTitleHeader(title: _l10n.progress),
                // Level Header
                UserLevelProgressCard(profile: profile),

                _buildPremiumBanner(),

                // Stats Row
                AppTitleHeader(title: _l10n.stats),
                _buildStatsRow(profile: profile),

                // Badges Section
                AppTitleHeader(title: _l10n.badges),
                _buildBadgesSection(profile: profile),

                // Activity Section
                AppTitleHeader(title: _l10n.activity),
                _buildActivityPreview(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMemoryWarning() {
    return BlocBuilder<AchievementCubit, AchievementState>(
      buildWhen: (previous, current) =>
          previous.storageUsagePercent != current.storageUsagePercent,
      builder: (context, state) {
        if (state.storageUsagePercent < 85) return const SizedBox();

        return Padding(
          padding: 12.paddingTop,
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
            style: _theme.textTheme.titleSmall,
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
                ContributedGraph(history: state.history),
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

  Widget _buildPremiumBanner() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      buildWhen: (previous, current) => previous.isPremium != current.isPremium,
      builder: (context, state) {
        if (state.isPremium) return const SizedBox();

        return Padding(
          padding: 12.paddingTop,
          child: InkWell(
            onTap: () => _cubit.navigator.goToPaywall(),
            borderRadius: 16.borderRadius,
            child: Container(
              padding: 16.paddingAll,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.withValues(alpha: 0.8),
                    Colors.orange.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: 16.borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.stars_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _l10n.upgradeToPremium,
                          style: _theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _l10n.paywallSubtitle,
                          style: _theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
