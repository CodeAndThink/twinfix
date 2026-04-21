import 'package:twinfix/generated/l10n.dart';

enum FaceCoverType {
  blur,
  pixelate,
  solid,
  emoji,
  glasses,
  eyeBar;

  bool get isBlur => this == blur;
  bool get isPixelate => this == pixelate;
  bool get isSolid => this == solid;
  bool get isEmoji => this == emoji;
  bool get isGlasses => this == glasses;
  bool get isEyeBar => this == eyeBar;

  bool get isAdjustable => isBlur || isPixelate || isSolid;
  bool get isEmojiStyle => isEmoji;
  bool get isFixed => isGlasses || isEyeBar;
}

extension FaceCoverTypeExtension on FaceCoverType {
  String get title {
    switch (this) {
      case FaceCoverType.blur:
        return S.current.blur;
      case FaceCoverType.pixelate:
        return S.current.pixelate;
      case FaceCoverType.solid:
        return S.current.solid;
      case FaceCoverType.emoji:
        return S.current.emoji;
      case FaceCoverType.glasses:
        return S.current.glasses;
      case FaceCoverType.eyeBar:
        return S.current.eyeBar;
    }
  }
}
