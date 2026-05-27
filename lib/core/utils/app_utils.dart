import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/configs/app_configs.dart';

class AppUtils {
  static String formatBytes(int bytes, {int decimals = 2}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return "${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}";
  }

  /// Calculate current Level based on total deleted photos/videos
  static int getLevelFromCount(int totalCount) {
    for (int i = AppConfigs.levelMilestones.length - 1; i >= 0; i--) {
      if (totalCount >= AppConfigs.levelMilestones[i]) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Calculate the progression percentage of current Level (from 0.0 to 1.0)
  static double getLevelProgress(int totalCount) {
    final currentLevel = getLevelFromCount(totalCount);

    // If reached max level in config
    if (currentLevel >= AppConfigs.levelMilestones.length) {
      return 1.0;
    }

    final currentMilestone = AppConfigs.levelMilestones[currentLevel - 1];
    final nextMilestone = AppConfigs.levelMilestones[currentLevel];

    final progress =
        (totalCount - currentMilestone) / (nextMilestone - currentMilestone);
    return progress.clamp(0.0, 1.0);
  }

  /// Get the number of additional photos to delete to reach next level
  static int getPhotosToNextLevel(int totalCount) {
    final currentLevel = getLevelFromCount(totalCount);
    if (currentLevel >= AppConfigs.levelMilestones.length) return 0;

    return (AppConfigs.levelMilestones[currentLevel] - totalCount).toInt();
  }

  /// Get the target milestone (number of photos) of next level
  static double getNextMilestone(int totalCount) {
    final currentLevel = getLevelFromCount(totalCount);
    if (currentLevel >= AppConfigs.levelMilestones.length) {
      return AppConfigs.levelMilestones.last;
    }
    return AppConfigs.levelMilestones[currentLevel];
  }

  static Future<XFile?> pickImage() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
