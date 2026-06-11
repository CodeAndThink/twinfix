import 'package:flutter/widgets.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/generated/l10n.dart';

enum BackgroundType {
  none,
  nature1,
  nature2,
  nature3,
  nature4,
  custom;

  bool get isNone => this == BackgroundType.none;
  bool get isNature1 => this == BackgroundType.nature1;
  bool get isNature2 => this == BackgroundType.nature2;
  bool get isNature3 => this == BackgroundType.nature3;
  bool get isNature4 => this == BackgroundType.nature4;
  bool get isCustom => this == BackgroundType.custom;
}

extension BackgroundTypeExtension on BackgroundType {
  String? get lightBackgroundPath {
    switch (this) {
      case BackgroundType.nature1:
        return AppAssets.bgLight1;
      case BackgroundType.nature2:
        return AppAssets.bgLight2;
      case BackgroundType.nature3:
        return AppAssets.bgLight3;
      case BackgroundType.nature4:
        return AppAssets.bgLight4;
      default:
        return null;
    }
  }

  String? get darkBackgroundPath {
    switch (this) {
      case BackgroundType.nature1:
        return AppAssets.bgDark1;
      case BackgroundType.nature2:
        return AppAssets.bgDark2;
      case BackgroundType.nature3:
        return AppAssets.bgDark3;
      case BackgroundType.nature4:
        return AppAssets.bgDark4;
      default:
        return null;
    }
  }

  String getName(BuildContext context) {
    switch (this) {
      case BackgroundType.none:
        return S.of(context).bgNone;
      case BackgroundType.nature1:
        return S.of(context).bgNature1;
      case BackgroundType.nature2:
        return S.of(context).bgNature2;
      case BackgroundType.nature3:
        return S.of(context).bgNature3;
      case BackgroundType.nature4:
        return S.of(context).bgNature4;
      case BackgroundType.custom:
        return S.of(context).bgCustom;
    }
  }
}
