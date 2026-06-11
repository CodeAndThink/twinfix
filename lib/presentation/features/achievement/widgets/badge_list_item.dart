import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

class BadgeListItem extends StatelessWidget {
  final String badgeId;
  final BadgeItem badge;
  final VoidCallback? onTap;

  const BadgeListItem({
    super.key,
    required this.badgeId,
    required this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Hero(
              tag: 'badge_$badgeId',
              child: AppTransparentContainer(
                backgroundColor: Colors.white,
                padding: 12.paddingAll,
                borderRadius: 16,
                height: 100,
                borderColor: primaryColor,
                child: Center(child: AppAssetImage(path: badge.iconUrl)),
              ),
            ),
            8.height,
            Text(
              badge.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
