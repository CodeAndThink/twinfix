import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_cubit.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';

class ImageEditorPageArgs {
  final XFile image;

  const ImageEditorPageArgs({required this.image});
}

class ImageEditorPage extends StatelessWidget {
  final ImageEditorPageArgs args;
  const ImageEditorPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageEditorCubit(navigator: ImageEditorNavigator(context)),
      child: ImageEditorChildPage(args: args),
    );
  }
}

class ImageEditorChildPage extends StatefulWidget {
  final ImageEditorPageArgs args;
  const ImageEditorChildPage({super.key, required this.args});

  @override
  State<ImageEditorChildPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorChildPage> {
  late final ImageEditorCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ImageEditorCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return ProImageEditor.file(
      File(widget.args.image.path),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (bytes) async {
          // In a real app, you'd save these bytes to a file.
          // For now, we'll just go back.
          _cubit.navigator.safePop();
        },
        onCloseEditor: (_) {
          _cubit.navigator.safePop();
        },
      ),
      configs: const ProImageEditorConfigs(
        designMode: ImageEditorDesignMode.material,
      ),
    );
  }
}
