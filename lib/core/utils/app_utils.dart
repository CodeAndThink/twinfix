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

  /// Tính toán Level hiện tại dựa trên tổng số ảnh/video đã xóa
  static int getLevelFromCount(int totalCount) {
    for (int i = AppConfigs.levelMilestones.length - 1; i >= 0; i--) {
      if (totalCount >= AppConfigs.levelMilestones[i]) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Tính toán % tiến trình của Level hiện tại (từ 0.0 đến 1.0)
  static double getLevelProgress(int totalCount) {
    final currentLevel = getLevelFromCount(totalCount);

    // Nếu đã đạt level tối đa trong config
    if (currentLevel >= AppConfigs.levelMilestones.length) {
      return 1.0;
    }

    final currentMilestone = AppConfigs.levelMilestones[currentLevel - 1];
    final nextMilestone = AppConfigs.levelMilestones[currentLevel];

    final progress =
        (totalCount - currentMilestone) / (nextMilestone - currentMilestone);
    return progress.clamp(0.0, 1.0);
  }

  /// Lấy số ảnh cần xóa thêm để lên level kế tiếp
  static int getPhotosToNextLevel(int totalCount) {
    final currentLevel = getLevelFromCount(totalCount);
    if (currentLevel >= AppConfigs.levelMilestones.length) return 0;

    return (AppConfigs.levelMilestones[currentLevel] - totalCount).toInt();
  }

  /// Lấy mốc kinh nghiệm (số lượng ảnh) của level kế tiếp
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
