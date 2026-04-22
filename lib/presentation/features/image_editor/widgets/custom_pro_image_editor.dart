import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

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
  late ThemeData _theme;
  late S _l10n;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

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
        theme: _theme,
        mainEditor: _buildMainEditorConfigs(),
        // paintEditor: PaintEditorConfigs(
        //   widgets: PaintEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.paint,
        //       hasUndoRedo: true,
        //     ),
        //   ),
        // ),
        // textEditor: TextEditorConfigs(
        //   widgets: TextEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.text,
        //       hasUndoRedo: false,
        //     ),
        //   ),
        // ),
        // cropRotateEditor: CropRotateEditorConfigs(
        //   widgets: CropRotateEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.crop,
        //       hasUndoRedo: true,
        //     ),
        //   ),
        // ),
        // filterEditor: FilterEditorConfigs(
        //   widgets: FilterEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.filter,
        //       hasUndoRedo: false,
        //     ),
        //   ),
        // ),
        // tuneEditor: TuneEditorConfigs(
        //   widgets: TuneEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.tune,
        //       hasUndoRedo: true,
        //     ),
        //   ),
        // ),
        // blurEditor: BlurEditorConfigs(
        //   widgets: BlurEditorWidgets(
        //     appBar: (editor, stream) => _buildSubAppbar(
        //       editor: editor,
        //       rebuildStream: stream,
        //       title: _l10n.blur,
        //       hasUndoRedo: false,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  MainEditorConfigs _buildMainEditorConfigs() {
    return MainEditorConfigs(
      widgets: MainEditorWidgets(
        appBar: (editor, rebuildStream) {
          return _buildMainAppbar(
            context: context,
            editor: editor,
            rebuildStream: rebuildStream,
          );
        },
        bottomBar: (editor, rebuildStream, key) {
          return _buildMainBottomBar(
            context: context,
            editor: editor,
            rebuildStream: rebuildStream,
            key: key,
          );
        },
      ),
    );
  }

  ReactiveAppbar _buildMainAppbar({
    required BuildContext context,
    required ProImageEditorState editor,
    required Stream<void> rebuildStream,
  }) {
    return ReactiveAppbar(
      stream: rebuildStream,
      builder: (_) {
        return CustomAppBar(
          title: _l10n.edit,
          onLeadingPressed: () {
            editor.closeEditor();
            widget.onClose();
          },
          actions: [
            IconButton(
              onPressed: editor.canUndo ? editor.undoAction : null,
              icon: Icon(
                Icons.undo_rounded,
                color: editor.canUndo ? null : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: editor.canRedo ? editor.redoAction : null,
              icon: Icon(
                Icons.redo_rounded,
                color: editor.canRedo ? null : Colors.grey,
              ),
            ),
            Padding(
              padding: 12.paddingRight,
              child: AppFilledButton(
                text: _l10n.save,
                onPressed: () async {
                  widget.onSaveStarted();
                  editor.doneEditing();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  ReactiveWidget<Widget> _buildMainBottomBar({
    required BuildContext context,
    required ProImageEditorState editor,
    required Stream<void> rebuildStream,
    required Key key,
  }) {
    return ReactiveWidget(
      stream: rebuildStream,
      builder: (_) {
        final isDark = _theme.brightness == Brightness.dark;
        return ClipRRect(
          key: key,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: isDark
                      ? [const Color(0xCC09161B), const Color(0xB3153035)]
                      : [
                          Colors.white.withValues(alpha: 0.78),
                          const Color(0xD8E4FFF7),
                        ],
                ),
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? AppColors.glassStroke
                        : _theme.colorScheme.secondary.withValues(alpha: 0.28),
                    width: 1.5,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToolButton(
                      icon: Icons.format_paint_rounded,
                      label: "Paint",
                      onPressed: () => editor.openPaintEditor(),
                    ),
                    _buildToolButton(
                      icon: Icons.text_fields_rounded,
                      label: "Text",
                      onPressed: () => editor.openTextEditor(),
                    ),
                    _buildToolButton(
                      icon: Icons.crop_rotate_rounded,
                      label: "Crop",
                      onPressed: () => editor.openCropRotateEditor(),
                    ),
                    _buildToolButton(
                      icon: Icons.filter_b_and_w_rounded,
                      label: "Filter",
                      onPressed: () => editor.openFilterEditor(),
                    ),
                    _buildToolButton(
                      icon: Icons.tune_rounded,
                      label: "Tune",
                      onPressed: () => editor.openTuneEditor(),
                    ),
                    _buildToolButton(
                      icon: Icons.blur_on_rounded,
                      label: "Blur",
                      onPressed: () => editor.openBlurEditor(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ReactiveAppbar _buildSubAppbar({
  //   required dynamic editor,
  //   required Stream<void> rebuildStream,
  //   required String title,
  //   required bool hasUndoRedo,
  // }) {
  //   return ReactiveAppbar(
  //     stream: rebuildStream,
  //     builder: (_) {
  //       return CustomAppBar(
  //         title: title,
  //         onLeadingPressed: () => Navigator.pop(context),
  //         actions: [
  //           if (hasUndoRedo) ...[
  //             IconButton(
  //               onPressed: editor.canUndo ? editor.undoAction : null,
  //               icon: Icon(
  //                 Icons.undo_rounded,
  //                 color: editor.canUndo ? null : Colors.grey,
  //               ),
  //             ),
  //             IconButton(
  //               onPressed: editor.canRedo ? editor.redoAction : null,
  //               icon: Icon(
  //                 Icons.redo_rounded,
  //                 color: editor.canRedo ? null : Colors.grey,
  //               ),
  //             ),
  //           ],
  //           Padding(
  //             padding: 12.paddingRight,
  //             child: AppFilledButton(
  //               text: _l10n.save,
  //               onPressed: () {
  //                 editor.doneEditing();
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // ReactiveAppbar _buildPaintAppbar({
  //   required PaintEditorState editor,
  //   required Stream<void> rebuildStream,
  //   required String title,
  //   required bool hasUndoRedo,
  // }) {
  //   return ReactiveAppbar(
  //     stream: rebuildStream,
  //     builder: (_) {
  //       return CustomAppBar(
  //         title: title,
  //         onLeadingPressed: () => Navigator.pop(context),
  //         actions: [
  //           IconButton(
  //             onPressed: () {
  //               editor.
  //             },
  //             icon: Icon(
  //               Icons,
  //               color: editor.canUndo ? null : Colors.grey,
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.redo_rounded,
  //               color: editor.canRedo ? null : Colors.grey,
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.undo_rounded,
  //               color: editor.canUndo ? null : Colors.grey,
  //             ),
  //           ),

  //           IconButton(
  //             onPressed: editor.canUndo ? editor.undoAction : null,
  //             icon: Icon(
  //               Icons.undo_rounded,
  //               color: editor.canUndo ? null : Colors.grey,
  //             ),
  //           ),
  //           IconButton(
  //             onPressed: editor.canRedo ? editor.redoAction : null,
  //             icon: Icon(
  //               Icons.redo_rounded,
  //               color: editor.canRedo ? null : Colors.grey,
  //             ),
  //           ),

  //           Padding(
  //             padding: 12.paddingRight,
  //             child: AppFilledButton(
  //               text: _l10n.save,
  //               onPressed: () {

  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: _theme.colorScheme.onSurface),
            style: IconButton.styleFrom(
              backgroundColor: _theme.colorScheme.surface.withValues(
                alpha: 0.5,
              ),
            ),
          ),
          4.height,
          Text(label, style: _theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
