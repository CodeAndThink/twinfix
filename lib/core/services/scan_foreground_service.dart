import 'dart:io';

import 'package:flutter/services.dart';
import 'package:twinfix/domain/enums/scan_type.dart';

/// Dart wrapper for Android Foreground Service used during scan operations.
///
/// This service shows a persistent notification with progress while scanning,
/// and a completion notification when done. Only active on Android.
class ScanForegroundService {
  ScanForegroundService._();
  static final instance = ScanForegroundService._();

  static const _channel = MethodChannel('com.truongngo.twinfix/scan_service');

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  /// Start the foreground service with an initial notification.
  /// [title] and [body] are the notification text (already localized by caller).
  Future<void> start({required String title, required String body}) async {
    if (!Platform.isAndroid) return;
    try {
      await _channel.invokeMethod('startService', {
        'title': title,
        'body': body,
      });
      _isRunning = true;
    } on PlatformException catch (_) {
      // Silently fail — scan still works, just without notification
    }
  }

  /// Update the notification progress.
  /// [current] and [total] drive the progress bar.
  Future<void> updateProgress({
    required String title,
    required String body,
    required int current,
    required int total,
  }) async {
    if (!Platform.isAndroid || !_isRunning) return;
    try {
      await _channel.invokeMethod('updateProgress', {
        'title': title,
        'body': body,
        'current': current,
        'total': total,
      });
    } on PlatformException catch (_) {
      // Silently fail
    }
  }

  /// Stop the foreground service and show a completion notification.
  /// [scanType] is used by native side to pass intent extras so Flutter
  /// can navigate to the correct result screen when user taps.
  Future<void> stop({
    required int resultCount,
    required String completionTitle,
    required String completionBody,
    required ScanType scanType,
  }) async {
    if (!Platform.isAndroid || !_isRunning) return;
    try {
      await _channel.invokeMethod('stopService', {
        'resultCount': resultCount,
        'completionTitle': completionTitle,
        'completionBody': completionBody,
        'scanType': scanType.value,
      });
      _isRunning = false;
    } on PlatformException catch (_) {
      _isRunning = false;
    }
  }

  /// Force stop without showing completion notification (e.g. user cancelled).
  Future<void> cancel() async {
    if (!Platform.isAndroid || !_isRunning) return;
    try {
      await _channel.invokeMethod('stopService', {
        'resultCount': 0,
        'completionTitle': '',
        'completionBody': '',
        'scanType': ScanType.cancelled.value,
      });
      _isRunning = false;
    } on PlatformException catch (_) {
      _isRunning = false;
    }
  }
}
