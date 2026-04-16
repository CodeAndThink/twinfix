import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/generated/l10n.dart';

enum PhotoType {
  normal,
  duplicate, // Giống hệt nhau về size, date
  burst, // Chụp liên tục (tương lai)
  blurry, // Ảnh mờ (tương lai)
  screenshot, // Ảnh chụp màn hình
  livePhoto; // Ảnh Live Photo

  bool get isNormal => this == PhotoType.normal;
  bool get isDuplicate => this == PhotoType.duplicate;
  bool get isBurst => this == PhotoType.burst;
  bool get isBlurry => this == PhotoType.blurry;
  bool get isScreenshot => this == PhotoType.screenshot;
  bool get isLivePhoto => this == PhotoType.livePhoto;
}

extension PhotoTypeExtension on PhotoType {
  IconData get icon {
    switch (this) {
      case PhotoType.livePhoto:
        return Icons.live_tv_rounded;
      case PhotoType.blurry:
        return Icons.blur_on_rounded;
      case PhotoType.screenshot:
        return Icons.screenshot_rounded;
      default:
        return Icons.photo_rounded;
    }
  }

  String get title {
    switch (this) {
      case PhotoType.livePhoto:
        return S.current.livePhotos;
      case PhotoType.blurry:
        return S.current.blurryPhotos;
      case PhotoType.screenshot:
        return S.current.screenshots;
      default:
        return '';
    }
  }

  String get description {
    switch (this) {
      case PhotoType.livePhoto:
        return S.current.livePhotosDescription;
      case PhotoType.blurry:
        return S.current.blurryPhotosDescription;
      case PhotoType.screenshot:
        return S.current.screenshotsDescription;
      default:
        return '';
    }
  }

  MediaType get mediaType {
    switch (this) {
      case PhotoType.livePhoto:
        return MediaType.image;
      case PhotoType.blurry:
        return MediaType.image;
      case PhotoType.screenshot:
        return MediaType.image;
      default:
        return MediaType.image;
    }
  }
}
