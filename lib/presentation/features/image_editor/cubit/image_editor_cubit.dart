import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_state.dart';

class ImageEditorCubit extends Cubit<ImageEditorState> {
  final ImageEditorNavigator navigator;
  ImageEditorCubit({required this.navigator}) : super(ImageEditorState());
}
