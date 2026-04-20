import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/navigator/face_blur_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class FaceBlurCubit extends BaseCubit<FaceBlurState> {
  final FaceBlurNavigator navigator;
  final XFile imageFile;
  late final FaceDetector _faceDetector;

  FaceBlurCubit({required this.imageFile, required this.navigator})
    : super(const FaceBlurState()) {
    final options = FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: false,
      enableClassification: false,
      enableTracking: false,
      performanceMode: FaceDetectorMode.fast,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> detectFaces() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final faces = await _faceDetector.processImage(inputImage);

      final faceRects = faces
          .map((face) => FaceRect(rect: face.boundingBox))
          .toList();

      // Get image size
      final bytes = await imageFile.readAsBytes();
      final decodedImage = await decodeImageFromList(bytes);
      final imageSize = Size(
        decodedImage.width.toDouble(),
        decodedImage.height.toDouble(),
      );

      emit(
        state.copyWith(
          faces: faceRects,
          imageSize: imageSize,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void toggleFaceCover(int index) {
    if (index >= 0 && index < state.faces.length) {
      final updatedFaces = List<FaceRect>.from(state.faces);
      final current = updatedFaces[index];
      updatedFaces[index] = current.copyWith(isEnabled: !current.isEnabled);
      emit(state.copyWith(faces: updatedFaces));
    }
  }

  void changeCoverStyle(FaceCoverStyle style) {
    emit(state.copyWith(coverStyle: style));
  }

  void setSaving(bool saving) {
    emit(state.copyWith(isSaving: saving));
  }

  @override
  Future<void> close() {
    _faceDetector.close();
    return super.close();
  }
}
