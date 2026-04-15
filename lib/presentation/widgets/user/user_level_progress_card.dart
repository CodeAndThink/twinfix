import 'package:flutter/material.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

class UserLevelProgressCard extends StatelessWidget {
  final UserProfile profile;

  const UserLevelProgressCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return DuolingoCard(
      borderColor: theme.colorScheme.primary,
      padding: AppSizes.s24.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.22),
                  AppColors.secondary.withValues(alpha: 0.16),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.diamond_outlined,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
          AppSizes.s12.height,
          Text(
            l10n.level(profile.currentLevel),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          AppSizes.s16.height,
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: profile.levelProgress),
            duration: 1500.milliseconds,
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppColors.placeholderBackground,
                    color: theme.colorScheme.primary,
                    minHeight: 16,
                    borderRadius: 12.borderRadius,
                  ),
                  AppSizes.s12.height,
                  Text(
                    '${AppUtils.formatBytes(profile.totalCleanedBytes)} / ${AppUtils.formatBytes(AppConfigs.getNextMilestone(profile.totalCleanedBytes).toInt())}',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    '(${(value * 100).toStringAsFixed(1)}%)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
