import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/extensions/extensions.dart';

import '../../../widgets/scaffold/app_scaffold.dart';

class AchievementDetailPageArgs {
  final BadgeItem badge;
  final bool isEarned;

  const AchievementDetailPageArgs({
    required this.badge,
    required this.isEarned,
  });
}

class AchievementDetailPage extends StatelessWidget {
  final AchievementDetailPageArgs args;

  const AchievementDetailPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: S.of(context).badges,
      isBack: true,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return SingleChildScrollView(
      padding: AppSizes.s24.paddingAll,
      child: Column(
        children: [
          // Badge Badge Visual
          Center(
            child: Hero(
              tag: 'badge_${args.badge.id}',
              child: Opacity(
                opacity: args.isEarned ? 1.0 : 0.4,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: args.isEarned
                        ? [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.shield,
                      size: 100,
                      color: args.isEarned
                          ? theme.colorScheme.primary
                          : AppColors.placeholderText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSizes.s40.height,

          // Badge Info Card
          Container(
            padding: AppSizes.s24.paddingAll,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppSizes.borderRadius.borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  args.badge.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSizes.s16.height,
                Text(
                  args.badge.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.placeholderText,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSizes.s32.height,

                // Progress / Status
                Container(
                  padding: AppSizes.s16.paddingAll,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: (AppSizes.borderRadius / 2).borderRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        args.isEarned ? Icons.check_circle : Icons.lock,
                        color: args.isEarned
                            ? AppColors.success
                            : AppColors.placeholderText,
                      ),
                      AppSizes.s12.width,
                      Expanded(
                        child: Text(
                          args.isEarned ? l10n.earned : l10n.notEarned,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: args.isEarned
                                ? AppColors.success
                                : AppColors.placeholderText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSizes.s32.height,

          // Requirements Details
          if (!args.isEarned) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.howToEarn,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSizes.s16.height,
            Text(l10n.howToEarnDescription, style: theme.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
