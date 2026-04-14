import 'package:flutter/material.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class UserLevelProgressCard extends StatelessWidget {
  final UserProfile profile;

  const UserLevelProgressCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppTransparentContainer(
      padding: AppSizes.s24.padding,
      color: theme.colorScheme.primary.withValues(alpha: 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.stars, size: 48, color: theme.colorScheme.primary),
          AppSizes.s8.height,
          Text(
            l10n.level(profile.currentLevel),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          AppSizes.s16.height,
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: profile.levelProgress),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppColors.placeholderBackground,
                    color: theme.colorScheme.primary,
                    minHeight: 12,
                    borderRadius: 10.borderRadius,
                  ),
                  AppSizes.s8.height,
                  Text(
                    '${AppUtils.formatBytes(profile.totalCleanedBytes)} / ${AppUtils.formatBytes(AppConfigs.getNextMilestone(profile.totalCleanedBytes).toInt())} (${(value * 100).toStringAsFixed(1)}%)',
                    style: theme.textTheme.bodySmall,
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
