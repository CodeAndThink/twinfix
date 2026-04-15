import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';

class AppTransparentContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? color;
  const AppTransparentContainer({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: (borderRadius ?? 36).borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: height,
          padding: padding ?? 8.paddingHorizontal,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color ??
                    (isDark
                        ? AppColors.surface.withValues(alpha: 0.78)
                        : Colors.white.withValues(alpha: 0.84)),
                isDark
                    ? AppColors.surfaceAlt.withValues(alpha: 0.68)
                    : const Color(0xCCDBFFF7),
              ],
            ),
            borderRadius: (borderRadius ?? 36).borderRadius,
            border: Border.all(
              color: isDark
                  ? AppColors.glassStroke
                  : AppColors.secondary.withValues(alpha: 0.24),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
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
