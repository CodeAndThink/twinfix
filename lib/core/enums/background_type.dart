import 'package:twinfix/core/constants/app_assets.dart';

enum BackgroundType {
  none,
  nature1,
  nature2,
  nature3,
  nature4;

  bool get isNone => this == BackgroundType.none;
  bool get isNature1 => this == BackgroundType.nature1;
  bool get isNature2 => this == BackgroundType.nature2;
  bool get isNature3 => this == BackgroundType.nature3;
  bool get isNature4 => this == BackgroundType.nature4;
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
}
