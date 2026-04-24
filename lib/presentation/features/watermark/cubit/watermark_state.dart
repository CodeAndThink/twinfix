import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class WatermarkState extends Equatable {
  final LoadStatus status;
  final String text;
  final int selectedTemplateIndex;
  final String? errorMessage;
  final bool isSaved;
  final double opacity;
  final double scale;
  final int density;
  final String? imagePath;

  const WatermarkState({
    this.status = LoadStatus.initial,
    this.text = '',
    this.selectedTemplateIndex = 0,
    this.errorMessage,
    this.isSaved = false,
    this.opacity = 1.0,
    this.scale = 1.0,
    this.density = 1,
    this.imagePath,
  });

  WatermarkState copyWith({
    LoadStatus? status,
    String? text,
    int? selectedTemplateIndex,
    String? errorMessage,
    bool? isSaved,
    double? opacity,
    double? scale,
    int? density,
    String? imagePath,
  }) {
    return WatermarkState(
      status: status ?? this.status,
      text: text ?? this.text,
      selectedTemplateIndex:
          selectedTemplateIndex ?? this.selectedTemplateIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      isSaved: isSaved ?? this.isSaved,
      opacity: opacity ?? this.opacity,
      scale: scale ?? this.scale,
      density: density ?? this.density,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
        status,
        text,
        selectedTemplateIndex,
        errorMessage,
        isSaved,
        opacity,
        scale,
        density,
        imagePath,
      ];
}
