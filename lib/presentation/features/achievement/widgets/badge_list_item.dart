import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

class BadgeListItem extends StatelessWidget {
  final String badgeId;
  final BadgeItem badge;
  final bool isEarned;
  final VoidCallback? onTap;

  const BadgeListItem({
    super.key,
    required this.badgeId,
    required this.badge,
    required this.isEarned,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final badgeColor = isEarned ? primaryColor : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Hero(
              tag: 'badge_$badgeId',
              child: AppTransparentContainer(
                padding: 12.paddingAll,
                borderRadius: 16,
                height: 100,
                borderColor: isEarned
                    ? badgeColor.withValues(alpha: 0.1)
                    : Colors.grey.shade200,
                child: Center(
                  child: Opacity(
                    opacity: isEarned ? 1 : 0.5,
                    child: AppAssetImage(path: badge.iconUrl),
                  ),
                ),
              ),
            ),
            8.height,
            Text(
              badge.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
