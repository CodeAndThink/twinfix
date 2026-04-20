import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_state.dart';

class ImageEditorCubit extends Cubit<ImageEditorState> {
  final ImageEditorNavigator navigator;
  final PhotoRepository photoRepository;

  ImageEditorCubit({required this.navigator, required this.photoRepository})
    : super(const ImageEditorState());

  Future<void> pickImage() async {
    final XFile? image = await AppUtils.pickImage();
    if (image != null) {
      emit(state.copyWith(selectedImage: image, status: LoadStatus.initial));
    }
  }

  Future<void> save({required Uint8List bytes, required bool isReplace}) async {
    emit(state.copyWith(status: LoadStatus.loading));

    try {
      await photoRepository.saveImage(
        bytes,
        title: 'edited_${DateTime.now().millisecondsSinceEpoch}',
      );
      // For MVP, isReplace follows the same logic as copy.
      // We can implement actual deletion later if needed.

      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
