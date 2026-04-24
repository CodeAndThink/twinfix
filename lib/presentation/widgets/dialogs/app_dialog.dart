import 'package:flutter/material.dart';
import '../../../../core/extensions/extensions.dart';
import '../buttons/app_filled_button.dart';
import '../buttons/app_outline_button.dart';

class AppDialog {
  final BuildContext context;

  const AppDialog(this.context);

  Future<T?> showConfirm<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
      ),
    );
  }

  Future<T?> showError<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'Close',
        confirmColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<T?> showSuccess<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'OK',
        confirmColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<T?> showInfo<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'Got it',
      ),
    );
  }
}

class _AppDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final Color? confirmColor;

  const _AppDialogWidget({
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 12.borderRadius),
      child: Padding(
        padding: 24.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            12.height,
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            24.height,
            Row(
              children: [
                if (cancelText != null)
                  Expanded(
                    child: AppOutlineButton(
                      text: cancelText!,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                if (cancelText != null && confirmText != null) 12.width,
                if (confirmText != null)
                  Expanded(
                    child: AppFilledButton(
                      text: confirmText!,
                      backgroundColor: confirmColor,
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm?.call();
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
