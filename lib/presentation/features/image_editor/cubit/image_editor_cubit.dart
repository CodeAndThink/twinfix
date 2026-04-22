import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ImageEditorCubit extends BaseCubit<ImageEditorState> {
  final ImageEditorNavigator navigator;
  final PhotoRepository photoRepository;

  ImageEditorCubit({required this.navigator, required this.photoRepository})
    : super(const ImageEditorState());

  Future<void> pickImage() async {
    final XFile? image = await AppUtils.pickImage();
    if (image != null) {
      safeEmit(
        state.copyWith(selectedImage: image, status: LoadStatus.initial),
      );
    }
  }

  Future<void> save({required Uint8List bytes}) async {
    safeEmit(state.copyWith(status: LoadStatus.loading));

    try {
      await photoRepository.saveImage(
        bytes,
        title: 'edited_${DateTime.now().millisecondsSinceEpoch}',
      );

      safeEmit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
