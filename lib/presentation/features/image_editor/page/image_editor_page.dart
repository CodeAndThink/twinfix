import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class ImageEditorPageArgs {
  final XFile image;

  const ImageEditorPageArgs({required this.image});
}

class ImageEditorPage extends StatefulWidget {
  final ImageEditorPageArgs args;
  const ImageEditorPage({super.key, required this.args});

  @override
  State<ImageEditorPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  @override
  Widget build(BuildContext context) {
    return ProImageEditor.file(
      File(widget.args.image.path),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (bytes) async {
          // In a real app, you'd save these bytes to a file.
          // For now, we'll just go back.
          Navigator.pop(context);
        },
        onCloseEditor: (_) {
          Navigator.pop(context);
        },
      ),
      configs: const ProImageEditorConfigs(
        designMode: ImageEditorDesignMode.material,
      ),
    );
  }
}
