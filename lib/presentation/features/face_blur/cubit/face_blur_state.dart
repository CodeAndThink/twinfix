import 'dart:ui';
import 'package:equatable/equatable.dart';

enum FaceCoverStyle { blur, pixelate, solid, emoji }

class FaceRect {
  final Rect rect;
  final bool isEnabled;

  FaceRect({required this.rect, this.isEnabled = true});

  FaceRect copyWith({Rect? rect, bool? isEnabled}) {
    return FaceRect(
      rect: rect ?? this.rect,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class FaceBlurState extends Equatable {
  final List<FaceRect> faces;
  final FaceCoverStyle coverStyle;
  final Size? imageSize;
  final bool isLoading;
  final bool isSaving;
  final String? error;

  const FaceBlurState({
    this.faces = const [],
    this.coverStyle = FaceCoverStyle.blur,
    this.imageSize,
    this.isLoading = true,
    this.isSaving = false,
    this.error,
  });

  FaceBlurState copyWith({
    List<FaceRect>? faces,
    FaceCoverStyle? coverStyle,
    Size? imageSize,
    bool? isLoading,
    bool? isSaving,
    String? error,
  }) {
    return FaceBlurState(
      faces: faces ?? this.faces,
      coverStyle: coverStyle ?? this.coverStyle,
      imageSize: imageSize ?? this.imageSize,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    faces,
    coverStyle,
    imageSize,
    isLoading,
    isSaving,
    error,
  ];
}
