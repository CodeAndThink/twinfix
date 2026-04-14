import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/features/achievement/cubit/achievement_state.dart';
import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement/pages/achievement_loading_page.dart';
import 'package:twinfix/presentation/features/achievement/widgets/badge_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

import '../../../../core/di/injection.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_sizes.dart';
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

        if (state.status.isSuccess && state.profile != null) {
          final profile = state.profile!;
          return RefreshIndicator(
            onRefresh: _cubit.loadProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
                left: AppSizes.s16,
                right: AppSizes.s16,
                bottom: MediaQuery.of(context).padding.bottom + 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMascotHeader(context),
                  // Memory Warning based on actual storage
                  _buildMemoryWarning(),

                  _buildSectionHeader(
                    _l10n.progress,
                    color: _theme.colorScheme.primary,
                  ),
                  // Level Header
                  UserLevelProgressCard(profile: profile),
                  AppSizes.s32.height,

                  // Stats Row
                  _buildSectionHeader(
                    _l10n.stats,
                    color: const Color(0xFF1CB0F6),
                  ),
                  _buildStatsRow(profile: profile),
                  AppSizes.s32.height,

                  // Badges Section
                  _buildSectionHeader(
                    _l10n.badges,
                    color: const Color(0xFF58CC02),
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

  Widget _buildMascotHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset('assets/images/capybara_mascot.png', height: 120),
          AppSizes.s12.width,
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: AppSizes.s16.padding,
              decoration: BoxDecoration(
                color: _theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: _theme.colorScheme.outlineVariant,
                  width: 3,
                ),
              ),
              child: Text(
                "Bạn đang làm rất tốt! Hãy xem tiến trình của mình bên dưới nhé!",
                style: _theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: _theme.textTheme.titleMedium?.copyWith(
          color: color ?? _theme.colorScheme.primary,
          letterSpacing: 2.0,
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
          padding: const EdgeInsets.only(bottom: AppSizes.s24),
          child: DuolingoCard(
            borderColor: _theme.colorScheme.error,
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
                AppSizes.s16.width,
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
                      AppSizes.s4.height,
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
    final int bytes = profile.totalCleanedBytes;
    String cleanedStr = AppUtils.formatBytes(bytes);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            Icons.local_fire_department,
            const Color(0xFFFF9600),
            _l10n.streakDays(profile.streakDays),
            _l10n.streaks,
          ),
        ),
        AppSizes.s12.width,
        Expanded(
          child: _buildStatCard(
            context,
            Icons.cleaning_services,
            const Color(0xFF1CB0F6),
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
    return DuolingoCard(
      borderColor: color,
      padding: AppSizes.s16.padding,
      child: Column(
        children: [
          Icon(icon, color: color, size: 36),
          AppSizes.s8.height,
          Text(
            value,
            style: _theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          AppSizes.s4.height,
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
      child: DuolingoCard(
        borderColor: const Color(0xFF58CC02),
        padding: AppSizes.s16.padding,
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
