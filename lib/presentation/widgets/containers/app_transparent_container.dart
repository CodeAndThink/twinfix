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
  final VoidCallback? onTap;
  const AppTransparentContainer({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: (borderRadius ?? 28).borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            padding: padding ?? 12.paddingAll,
            decoration: BoxDecoration(
              borderRadius: (borderRadius ?? 36).borderRadius,
              border: Border.all(
                color: isDark
                    ? color ?? AppColors.glassStroke
                    : color ??
                          theme.colorScheme.secondary.withValues(alpha: 0.24),
                width: 1.5,
              ),
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
      ),
    );
  }
}
