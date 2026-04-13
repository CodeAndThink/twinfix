import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/data/entities/navigation_item.dart';
import 'package:twinfix/generated/l10n.dart';

class LiquidGlassNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const LiquidGlassNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final items = [
      NavigationItem(
        icon: Icons.cleaning_services_outlined,
        activeIcon: Icons.cleaning_services,
        label: l10n.tabScan,
      ),
      NavigationItem(
        icon: Icons.emoji_events_outlined,
        activeIcon: Icons.emoji_events,
        label: l10n.tabDashboard,
      ),
    ];

    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: 12.paddingHorizontal,
        child: ClipRRect(
          borderRadius: 36.borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              height: 72,
              padding: 8.paddingHorizontal,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.4),
                borderRadius: 36.borderRadius,
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 24,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(items.length, (index) {
                  final isSelected = currentIndex == index;
                  return GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: 600.milliseconds,
                      curve: Curves.elasticOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 24 : 8,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: 24.borderRadius,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected
                                ? items[index].activeIcon
                                : items[index].icon,
                            color: isSelected
                                ? colorScheme.primary
                                : theme.iconTheme.color?.withValues(alpha: 0.7),
                            size: 24,
                          ),
                          AnimatedSize(
                            duration: 400.milliseconds,
                            curve: Curves.easeOutCirc,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.15,
                              ),
                              child: SizedBox(
                                width: isSelected ? null : 0,
                                child: isSelected
                                    ? Padding(
                                        padding: 8.paddingLeft,
                                        child: Text(
                                          items[index].label,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                color: colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
