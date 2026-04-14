import 'package:flutter/material.dart';
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
    final backgroundColor = color ?? theme.cardColor;
    final effectColor = borderColor ?? theme.colorScheme.outlineVariant;

    return Container(
      decoration: BoxDecoration(
        color: effectColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: sideHeight),
        padding: padding ?? const EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: effectColor, width: borderWidth),
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
          color: sideColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.translationValues(0, _isPressed ? widget.sideHeight : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: sideColor, width: 2),
          ),
          child: DefaultTextStyle(
            style: theme.textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
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
