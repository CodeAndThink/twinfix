import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/domain/enums/feature_item.dart';

enum OtherFeature implements FeatureItem {
  removeGPS,
  addWaterMark,
  blurFace;

  bool get isRemoveGPS => this == OtherFeature.removeGPS;
  bool get isAddWaterMark => this == OtherFeature.addWaterMark;
  bool get isBlurFace => this == OtherFeature.blurFace;

  @override
  IconData get icon {
    switch (this) {
      case OtherFeature.removeGPS:
        return Icons.location_off_rounded;
      case OtherFeature.addWaterMark:
        return Icons.water_drop_rounded;
      case OtherFeature.blurFace:
        return Icons.screenshot_rounded;
    }
  }

  @override
  String get title {
    switch (this) {
      case OtherFeature.removeGPS:
        return S.current.removeGPS;
      case OtherFeature.addWaterMark:
        return S.current.addWaterMark;
      case OtherFeature.blurFace:
        return S.current.blurFace;
    }
  }

  @override
  String get description {
    switch (this) {
      case OtherFeature.removeGPS:
        return S.current.removeGPSDescription;
      case OtherFeature.addWaterMark:
        return S.current.addWaterMarkDescription;
      case OtherFeature.blurFace:
        return S.current.blurFaceDescription;
    }
  }

  MediaType get mediaType {
    switch (this) {
      case OtherFeature.removeGPS:
        return MediaType.image;
      case OtherFeature.addWaterMark:
        return MediaType.image;
      case OtherFeature.blurFace:
        return MediaType.image;
    }
  }
}
