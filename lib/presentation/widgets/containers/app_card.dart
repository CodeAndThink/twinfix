import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import '../../../../core/constants/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? color;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardContent = Container(
      padding: padding ?? 12.paddingAll,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color ?? theme.cardColor,
            isDark
                ? theme.colorScheme.surface.withValues(alpha: 0.88)
                : const Color(0xFFF0FFFB),
          ],
        ),
        borderRadius: (borderRadius ?? 12).borderRadius,
        border: Border.all(
          color: isDark
              ? AppColors.glassStroke
              : theme.colorScheme.secondary.withValues(alpha: 0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.seed.withValues(alpha: isDark ? 0.14 : 0.06),
            blurRadius: 20,
            spreadRadius: -6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: (borderRadius ?? 12).borderRadius,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
