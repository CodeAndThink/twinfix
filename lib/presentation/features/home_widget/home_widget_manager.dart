import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:storage_space/storage_space.dart';
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

      final ui = StorageWidgetUI(
        usedSpace: storageSpace.used.toDouble(),
        totalSpace: storageSpace.total.toDouble(),
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
