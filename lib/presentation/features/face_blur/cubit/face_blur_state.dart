import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/core/enums/load_status.dart';

class FaceRect {
  final Rect rect;
  final bool isEnabled;
  final Map<FaceLandmarkType, Offset> landmarks;

  FaceRect({
    required this.rect,
    this.isEnabled = true,
    this.landmarks = const {},
  });

  FaceRect copyWith({
    Rect? rect,
    bool? isEnabled,
    Map<FaceLandmarkType, Offset>? landmarks,
  }) {
    return FaceRect(
      rect: rect ?? this.rect,
      isEnabled: isEnabled ?? this.isEnabled,
      landmarks: landmarks ?? this.landmarks,
    );
  }
}

class FaceBlurState extends Equatable {
  final LoadStatus analyzeStatus;
  final LoadStatus saveStatus;
  final List<FaceRect> faces;
  final FaceCoverType coverStyle;
  final Size? imageSize;
  final String? error;
  final String emoji;
  final double intensity;
  final double opacity;
  final double sizeFactor;

  const FaceBlurState({
    this.analyzeStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.faces = const [],
    this.coverStyle = FaceCoverType.blur,
    this.imageSize,
    this.error,
    this.emoji = ' 😀',
    this.intensity = 15.0,
    this.opacity = 1.0,
    this.sizeFactor = 0.0,
  });

  FaceBlurState copyWith({
    LoadStatus? analyzeStatus,
    LoadStatus? saveStatus,
    List<FaceRect>? faces,
    FaceCoverType? coverStyle,
    Size? imageSize,
    String? error,
    String? emoji,
    double? intensity,
    double? opacity,
    double? sizeFactor,
  }) {
    return FaceBlurState(
      analyzeStatus: analyzeStatus ?? this.analyzeStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      faces: faces ?? this.faces,
      coverStyle: coverStyle ?? this.coverStyle,
      imageSize: imageSize ?? this.imageSize,
      error: error ?? this.error,
      emoji: emoji ?? this.emoji,
      intensity: intensity ?? this.intensity,
      opacity: opacity ?? this.opacity,
      sizeFactor: sizeFactor ?? this.sizeFactor,
    );
  }

  @override
  List<Object?> get props => [
        analyzeStatus,
        saveStatus,
        faces,
        coverStyle,
        imageSize,
        error,
        emoji,
        intensity,
        opacity,
        sizeFactor,
      ];
}
