import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class CustomProImageEditor extends StatefulWidget {
  final String imagePath;
  final ValueChanged<Uint8List> onSaveComplete;
  final VoidCallback onClose;
  final VoidCallback onSaveStarted;

  const CustomProImageEditor({
    super.key,
    required this.imagePath,
    required this.onSaveComplete,
    required this.onClose,
    required this.onSaveStarted,
  });

  @override
  State<CustomProImageEditor> createState() => _CustomProImageEditorState();
}

class _CustomProImageEditorState extends State<CustomProImageEditor> {
  @override
  Widget build(BuildContext context) {
    return ProImageEditor.file(
      File(widget.imagePath),
      key: ValueKey(widget.imagePath),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (bytes) async {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              widget.onSaveComplete(bytes);
            }
          });
        },
      ),
      configs: ProImageEditorConfigs(
        designMode: ImageEditorDesignMode.cupertino,
      ),
    );
  }
}
