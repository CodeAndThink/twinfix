import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_space/storage_space.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/theme/app_theme.dart';
import 'storage_widget_ui.dart';

class HomeWidgetManager {
  static const String appGroupId = 'group.twinfix';
  static const String androidWidgetName = 'StorageWidgetProvider';

  static Future<void> updateWidget() async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);

      final StorageSpace storageSpace = await getStorageSpace(
        lowOnSpaceThreshold: 0,
        fractionDigits: 1,
      );

      // Read user's saved locale
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code') ?? 'en';

      final ui = DefaultAssetBundle(
        bundle: rootBundle,
        child: Localizations(
          locale: Locale(languageCode),
          delegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: Theme(
            data: AppTheme.dark(),
            child: MediaQuery(
              data: const MediaQueryData(),
              child: StorageWidgetUI(
                usedSpace: storageSpace.used.toDouble(),
                totalSpace: storageSpace.total.toDouble(),
              ),
            ),
          ),
        ),
      );

      // Render the widget as an image
      await HomeWidget.renderFlutterWidget(
        ui,
        logicalSize: const Size(250, 250),
        key: 'widget_image',
      );

      // Update the widget
      await HomeWidget.updateWidget(androidName: androidWidgetName);
    } catch (e) {
      debugPrint('Failed to update home widget: $e');
    }
  }
}
