import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/domain/enums/feature_item.dart';

enum OtherFeature implements FeatureItem {
  removeGPS,
  addWaterMark,
  blurFace,
  document,
  edit,
  blurDetection;

  bool get isRemoveGPS => this == OtherFeature.removeGPS;
  bool get isAddWaterMark => this == OtherFeature.addWaterMark;
  bool get isBlurFace => this == OtherFeature.blurFace;
  bool get isDocument => this == OtherFeature.document;
  bool get isEdit => this == OtherFeature.edit;
  bool get isBlurDetection => this == OtherFeature.blurDetection;

  @override
  IconData get icon {
    switch (this) {
      case OtherFeature.removeGPS:
        return Icons.location_off_rounded;
      case OtherFeature.addWaterMark:
        return Icons.water_drop_rounded;
      case OtherFeature.blurFace:
        return Icons.screenshot_rounded;
      case OtherFeature.document:
        return Icons.description_rounded;
      case OtherFeature.edit:
        return Icons.edit_rounded;
      case OtherFeature.blurDetection:
        return Icons.blur_on_rounded;
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
      case OtherFeature.document:
        return S.current.document;
      case OtherFeature.edit:
        return S.current.edit;
      case OtherFeature.blurDetection:
        return S.current.blurryPhotos;
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
      case OtherFeature.document:
        return S.current.documentDescription;
      case OtherFeature.edit:
        return S.current.editDescription;
      case OtherFeature.blurDetection:
        return S.current.blurryPhotosDescription;
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
      case OtherFeature.document:
        return MediaType.image;
      case OtherFeature.edit:
        return MediaType.image;
      case OtherFeature.blurDetection:
        return MediaType.image;
    }
  }
}
