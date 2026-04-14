import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';

class UserLevelProgressCard extends StatelessWidget {
  final UserProfile profile;

  const UserLevelProgressCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Container(
      padding: AppSizes.s24.padding,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: AppSizes.borderRadius.borderRadius,
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars, size: 48, color: AppColors.primary),
          AppSizes.s8.height,
          Text(
            l10n.level(profile.currentLevel),
            style: theme.textTheme.headlineMedium?.copyWith(
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
            l10n.toNextLevel(
              '${(profile.levelProgress * 100).toStringAsFixed(1)}%',
            ),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
