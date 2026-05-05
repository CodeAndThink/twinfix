import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/navigator/face_blur_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class FaceBlurCubit extends BaseCubit<FaceBlurState> {
  final FaceBlurNavigator navigator;
  final PhotoRepository photoRepository;
  final XFile imageFile;
  late final FaceDetector _faceDetector;

  FaceBlurCubit({
    required this.imageFile,
    required this.navigator,
    required this.photoRepository,
  }) : super(const FaceBlurState()) {
    final options = FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: true,
      enableClassification: false,
      enableTracking: false,
      performanceMode: FaceDetectorMode.fast,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> detectFaces() async {
    if (state.analyzeStatus.isLoading) return;
    emit(state.copyWith(analyzeStatus: LoadStatus.loading, error: null));
    try {
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final faces = await _faceDetector.processImage(inputImage);

      final faceRects = faces.map((face) {
        final Map<FaceLandmarkType, Offset> landmarks = {};
        for (final entry in face.landmarks.entries) {
          final landmark = entry.value;
          if (landmark != null) {
            landmarks[entry.key] = Offset(
              landmark.position.x.toDouble(),
              landmark.position.y.toDouble(),
            );
          }
        }

        return FaceRect(rect: face.boundingBox, landmarks: landmarks);
      }).toList();

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
          analyzeStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(analyzeStatus: LoadStatus.failure, error: e.toString()),
      );
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

  void changeCoverStyle({required FaceCoverType style}) {
    emit(state.copyWith(coverStyle: style));
  }

  void setSaving({required bool saving}) {
    emit(
      state.copyWith(
        saveStatus: saving ? LoadStatus.loading : LoadStatus.success,
      ),
    );
  }

  void setIntensity(double value) {
    emit(state.copyWith(intensity: value));
  }

  void setOpacity(double value) {
    emit(state.copyWith(opacity: value));
  }

  void setSizeFactor(double value) {
    emit(state.copyWith(sizeFactor: value));
  }

  void setEmoji() async {
    final emoji = await navigator.dialog.showEmojiDialog();
    if (emoji != null) {
      emit(state.copyWith(emoji: emoji));
    }
  }

  Future<void> saveImage(Uint8List pngBytes) async {
    try {
      setSaving(saving: true);

      await photoRepository.saveImage(
        pngBytes,
        title: 'faceblur_${DateTime.now().millisecondsSinceEpoch}',
      );

      navigator.flushBar.showSuccess(message: S.current.imageSaved);
    } catch (e) {
      navigator.flushBar.showError(message: S.current.error(e.toString()));
    } finally {
      setSaving(saving: false);
    }
  }

  @override
  Future<void> close() {
    _faceDetector.close();
    return super.close();
  }
}
