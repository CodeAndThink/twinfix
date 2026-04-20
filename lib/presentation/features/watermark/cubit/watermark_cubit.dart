import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/models/watermark_template.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_painter.dart';
import 'package:twinfix/presentation/features/watermark/navigator/watermark_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class WatermarkCubit extends BaseCubit<WatermarkState> {
  final PhotoRepository photoRepository;
  final WatermarkNavigator navigator;
  final _picker = ImagePicker();

  WatermarkCubit({required this.photoRepository, required this.navigator})
    : super(const WatermarkState());

  void onTextChanged(String value) {
    emit(state.copyWith(text: value));
  }

  void onTemplateSelected(int index) {
    emit(state.copyWith(selectedTemplateIndex: index));
  }

  void onOpacityChanged(double value) {
    emit(state.copyWith(opacity: value));
  }

  void onScaleChanged(double value) {
    emit(state.copyWith(scale: value));
  }

  void onDensityChanged(double value) {
    emit(state.copyWith(density: value.toInt()));
  }

  void onImagePathChanged(String path) {
    emit(state.copyWith(imagePath: path));
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImagePathChanged(image.path);
    }
  }

  Future<void> save({required bool isReplace}) async {
    final imagePath = state.imagePath;
    if (imagePath == null) return;

    if (state.text.isEmpty) {
      emit(state.copyWith(errorMessage: S.current.pleaseEnterWatermarkText));
      return;
    }

    emit(state.copyWith(status: LoadStatus.loading));

    try {
      final bytes = await File(imagePath).readAsBytes();

      // Load image as ui.Image
      final Codec codec = await instantiateImageCodec(bytes);
      final FrameInfo fi = await codec.getNextFrame();
      final Image uiImage = fi.image;

      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      final size = Size(uiImage.width.toDouble(), uiImage.height.toDouble());

      // 1. Draw original image
      canvas.drawImage(uiImage, Offset.zero, Paint());

      // 2. Draw watermark using the same painter logic
      final painter = WatermarkPainter(
        text: state.text,
        opacity: state.opacity,
        scale: state.scale,
        density: state.density,
        template:
            WatermarkTemplate.defaultTemplates[state.selectedTemplateIndex],
      );
      painter.paint(canvas, size);

      // 3. Convert to bytes
      final picture = recorder.endRecording();
      final img = await picture.toImage(uiImage.width, uiImage.height);
      final byteData = await img.toByteData(format: ImageByteFormat.png);
      final modifiedBytes = byteData!.buffer.asUint8List();

      if (isReplace) {
        // For MVP, replacing saves a new copy. If we have asset ID, we'd delete original.
        await photoRepository.saveImage(
          modifiedBytes,
          title: 'watermarked_${DateTime.now().millisecondsSinceEpoch}',
        );
      } else {
        await photoRepository.saveImage(
          modifiedBytes,
          title: 'watermarked_${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      emit(state.copyWith(status: LoadStatus.success, isSaved: true));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
