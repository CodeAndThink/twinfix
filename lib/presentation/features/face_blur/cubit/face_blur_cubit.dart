import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/navigator/face_blur_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class FaceBlurCubit extends BaseCubit<FaceBlurState> {
  final FaceBlurNavigator navigator;
  final PhotoRepository photoRepository;

  late final FaceDetector _faceDetector;

  FaceBlurCubit({required this.navigator, required this.photoRepository})
    : super(const FaceBlurState()) {
    final options = FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: true,
      enableClassification: false,
      enableTracking: false,
      performanceMode: FaceDetectorMode.fast,
    );
    _faceDetector = FaceDetector(options: options);
  }

  void init({required XFile image}) {
    emit(state.copyWith(imageFile: image));
    detectFaces();
  }

  Future<void> detectFaces() async {
    if (state.analyzeStatus.isLoading) return;
    emit(state.copyWith(analyzeStatus: LoadStatus.loading, error: null));
    try {
      final inputImage = InputImage.fromFilePath(state.imageFile?.path ?? "");
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
      final bytes = await state.imageFile?.readAsBytes();
      if (bytes == null) return;
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

      navigator.dialog.showImageProcessedSuccessDialog(
        imageBytes: pngBytes,
        onShare: () {
          AppUtils.shareImage(pngBytes);
        },
        onDone: () {
          navigator.safePop();
        },
      );
    } catch (e) {
      navigator.flushBar.showError(message: S.current.error(e.toString()));
    } finally {
      setSaving(saving: false);
    }
  }

  void resetValues() {
    emit(
      state.copyWith(
        intensity: 15.0,
        opacity: 1.0,
        sizeFactor: 0.0,
        emoji: '😀',
      ),
    );
  }

  Future<void> pickNewImage() async {
    final image = await AppUtils.pickImage();
    if (image != null) {
      emit(const FaceBlurState());
      emit(state.copyWith(imageFile: image));
      detectFaces();
    }
  }

  @override
  Future<void> close() {
    _faceDetector.close();
    return super.close();
  }
}
