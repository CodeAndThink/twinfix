import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ImageEditorState extends Equatable {
  final XFile? selectedImage;
  final Uint8List? processedImageBytes;
  final LoadStatus status;
  final String? errorMessage;

  const ImageEditorState({
    this.selectedImage,
    this.processedImageBytes,
    this.status = LoadStatus.initial,
    this.errorMessage,
  });

  ImageEditorState copyWith({
    XFile? selectedImage,
    Uint8List? processedImageBytes,
    LoadStatus? status,
    String? errorMessage,
  }) {
    return ImageEditorState(
      selectedImage: selectedImage ?? this.selectedImage,
      processedImageBytes: processedImageBytes ?? this.processedImageBytes,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedImage,
    processedImageBytes,
    status,
    errorMessage,
  ];
}
