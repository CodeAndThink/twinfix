import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
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
      borderRadius: AppSizes.borderRadius.borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: height,
          padding: padding ?? 8.paddingHorizontal,
          decoration: BoxDecoration(
            color:
                color ??
                (isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.4)),
            borderRadius: (borderRadius ?? 36).borderRadius,
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
          child: child,
        ),
      ),
    );
  }
}
