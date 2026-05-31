import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class UserLevelProgressCard extends StatelessWidget {
  final UserProfile? profile;

  const UserLevelProgressCard({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppTransparentContainer(
      borderColor: theme.colorScheme.primary,
      padding: 12.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: 12.paddingAll,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.22),
                  theme.colorScheme.secondary.withValues(alpha: 0.16),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.diamond_outlined,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          8.height,
          Text(
            l10n.level(profile?.currentLevel ?? 0),
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          8.height,
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: profile?.levelProgress ?? 0),
            duration: 1000.milliseconds,
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: value,
                    backgroundColor: theme.colorScheme.surfaceDim,
                    color: theme.colorScheme.primary,
                    minHeight: 12,
                    borderRadius: 12.borderRadius,
                  ),
                  8.height,
                  Text(
                    '${profile?.totalDeletedPhotos} / ${AppUtils.getNextMilestone(profile?.totalDeletedPhotos ?? 0).toInt()} ${l10n.totalPhotos(profile?.totalDeletedPhotos ?? 0).split(' ').last}',
                    style: theme.textTheme.titleSmall,
                  ),
                  2.height,
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
