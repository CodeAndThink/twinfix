import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/data/entities/navigation_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
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
      NavigationItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: l10n.tabSettings,
      ),
    ];

    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: 20.paddingHorizontal,
        child: AppTransparentContainer(
          height: 72,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(items.length, (index) {
                  final isSelected = currentIndex == index;
                  return InkWell(
                    onTap: () => onTap(index),
                    borderRadius: 24.borderRadius,
                    child: AnimatedContainer(
                      width: maxWidth / 3,
                      duration: 600.milliseconds,
                      curve: Curves.elasticOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 20 : 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: 24.borderRadius,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Flexible(
                            child: AnimatedSize(
                              duration: 400.milliseconds,
                              curve: Curves.easeOutCirc,
                              child: isSelected
                                  ? Padding(
                                      padding: 4.paddingLeft,
                                      child: Text(
                                        items[index].label,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                              color: colorScheme.primary,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
