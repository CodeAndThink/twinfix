import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/data/entities/navigation_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/ads/banner_ad_widget.dart';
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
        icon: Icons.grid_view_outlined,
        activeIcon: Icons.grid_view,
        label: l10n.tabOtherFeatures,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BannerAdWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AppTransparentContainer(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
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
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: maxWidth / (items.length + 1),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: [
                                          colorScheme.primary.withValues(
                                            alpha: 0.18,
                                          ),
                                          colorScheme.primary.withValues(
                                            alpha: 0.12,
                                          ),
                                        ],
                                      )
                                    : null,
                                borderRadius: 24.borderRadius,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.glassStroke
                                      : Colors.transparent,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: colorScheme.primary.withValues(
                                            alpha: 0.18,
                                          ),
                                          blurRadius: 24,
                                          spreadRadius: -10,
                                        ),
                                      ]
                                    : null,
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
                                        : theme.iconTheme.color?.withValues(
                                            alpha: 0.68,
                                          ),
                                    size: 22,
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
                                                style: theme
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      color:
                                                          colorScheme.primary,
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
            ),
          ),
        ],
      ),
    );
  }
}
