import 'package:flutter/material.dart';
import '../../../../core/extensions/extensions.dart';

class AppOutlineButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? foregroundColor;

  const AppOutlineButton({
    super.key,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColor = foregroundColor ?? theme.colorScheme.onSurface;

    final style = OutlinedButton.styleFrom(
      foregroundColor: themeColor,
      side: BorderSide(color: themeColor, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48),
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[Icon(icon, size: 20), 8.width],
                  Text(
                    text,
                    style: (textStyle ?? theme.textTheme.titleSmall)?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
