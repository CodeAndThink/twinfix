import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';

class AppTransparentContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BorderRadiusGeometry? border;
  final Color? color;
  final VoidCallback? onTap;
  const AppTransparentContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.border,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: border ?? (borderRadius ?? 28).borderRadius,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          padding: padding ?? 12.paddingAll,
          decoration: BoxDecoration(
            borderRadius: border ?? (borderRadius ?? 28).borderRadius,
            border: Border.all(
              color: isDark
                  ? color ?? AppColors.glassStroke
                  : color ??
                        theme.colorScheme.secondary.withValues(alpha: 0.24),
              width: 1.5,
            ),
            color: theme.colorScheme.surface.withValues(alpha: 0.8),
            boxShadow: [
              BoxShadow(
                color: (color ?? theme.colorScheme.primary).withValues(
                  alpha: isDark ? 0.18 : 0.08,
                ),
                blurRadius: 24,
                spreadRadius: -6,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
