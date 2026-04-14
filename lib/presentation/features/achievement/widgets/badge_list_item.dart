import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/badge_item.dart';

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

    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: isEarned ? 1.0 : 0.5,
        child: Column(
          children: [
            Hero(
              tag: 'badge_$badgeId',
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.placeholderBackground,
                  shape: BoxShape.circle,
                  border: isEarned
                      ? Border.all(color: theme.colorScheme.primary, width: 2)
                      : null,
                ),
                child: const Center(
                  child: Icon(
                    Icons.shield,
                    size: 40,
                    color: AppColors.placeholderText,
                  ),
                ),
              ),
            ),
            AppSizes.s8.height,
            Text(
              badge.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isEarned ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
