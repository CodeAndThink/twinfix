import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';

class DuolingoCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final double sideHeight;
  final EdgeInsetsGeometry? padding;

  const DuolingoCard({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.borderWidth = 2,
    this.sideHeight = 4,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = color ?? theme.cardColor;
    final effectColor = borderColor ?? theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: effectColor.withValues(alpha: isDark ? 0.24 : 0.12),
            blurRadius: 28,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: sideHeight),
        padding: padding ?? const EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor,
              isDark
                  ? AppColors.surfaceAlt.withValues(alpha: 0.82)
                  : const Color(0xFFF4FFFC),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: effectColor.withValues(alpha: 0.72),
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}

class DuolingoButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? sideColor;
  final double sideHeight;

  const DuolingoButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.sideColor,
    this.sideHeight = 4,
  });

  @override
  State<DuolingoButton> createState() => _DuolingoButtonState();
}

class _DuolingoButtonState extends State<DuolingoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.onPressed == null) {
      return _buildDisabled();
    }

    final theme = Theme.of(context);
    final mainColor = widget.color ?? theme.colorScheme.primary;
    final sideColor = widget.sideColor ?? _getDarkerColor(mainColor);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(bottom: _isPressed ? 0 : widget.sideHeight),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: mainColor.withValues(alpha: 0.32),
              blurRadius: 20,
              spreadRadius: -8,
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.translationValues(
            0,
            _isPressed ? widget.sideHeight : 0,
            0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [mainColor, Color.lerp(mainColor, Colors.white, 0.15)!],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: sideColor, width: 1.5),
          ),
          child: DefaultTextStyle(
            style: theme.textTheme.labelLarge!.copyWith(
              color: const Color(0xFF04120E),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildDisabled() {
    return Container(
      padding: EdgeInsets.only(bottom: widget.sideHeight),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF8EA7B2).withValues(alpha: 0.24),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF8EA7B2), width: 1.5),
        ),
        child: widget.child,
      ),
    );
  }

  Color _getDarkerColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }
}
