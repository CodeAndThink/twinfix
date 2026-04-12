import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class AppFlushBar {
  final BuildContext context;

  const AppFlushBar(this.context);

  void showSuccess({required String message}) {
    _show(
      message: message,
      icon: Icons.check_circle_outline,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  void showError({required String message}) {
    _show(message: message, icon: Icons.error_outline, color: Theme.of(context).colorScheme.error);
  }

  void showWarning({required String message}) {
    _show(
      message: message,
      icon: Icons.warning_amber_rounded,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }

  void showInfo({required String message}) {
    _show(message: message, icon: Icons.info_outline, color: Theme.of(context).colorScheme.secondary);
  }

  void _show({
    required String message,
    required IconData icon,
    required Color color,
  }) async {
    await Haptics.vibrate(HapticsType.light);

    if (!context.mounted) return;

    Flushbar(
      message: message,
      icon: Icon(icon, size: 28.0, color: color),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: color,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Theme.of(context).colorScheme.surface,
      messageColor: Theme.of(context).colorScheme.onSurface,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ).show(context);
  }
}
