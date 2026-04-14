import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

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
              child: DuolingoCard(
                padding: const EdgeInsets.all(8),
                borderColor: badgeColor,
                sideHeight: 4,
                color: isEarned
                    ? badgeColor.withValues(alpha: 0.1)
                    : Colors.grey.shade200,
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      isEarned ? Icons.shield : Icons.shield_outlined,
                      size: 36,
                      color: badgeColor,
                    ),
                  ),
                ),
              ),
            ),
            AppSizes.s8.height,
            Text(
              badge.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isEarned ? FontWeight.normal : FontWeight.bold,
                color: isEarned ? theme.colorScheme.onSurface : Colors.grey,
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
