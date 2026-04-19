import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_cubit.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_state.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/dialogs/app_dialog.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

class ImageEditorPageArgs {
  final XFile? image;

  const ImageEditorPageArgs({this.image});
}

class ImageEditorPage extends StatelessWidget {
  final ImageEditorPageArgs? args;
  const ImageEditorPage({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageEditorCubit(
        navigator: ImageEditorNavigator(context),
        photoRepository: locator<PhotoRepository>(),
      ),
      child: ImageEditorChildPage(args: args),
    );
  }
}

class ImageEditorChildPage extends StatefulWidget {
  final ImageEditorPageArgs? args;
  const ImageEditorChildPage({super.key, this.args});

  @override
  State<ImageEditorChildPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorChildPage> {
  late final ImageEditorCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ImageEditorCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.args?.image != null) {
        // If an image was passed, use it
        // This won't happen often with the new flow, but keeps it compatible
      } else {
        // Auto pick image on start
        _cubit.pickImage();
      }
    });
  }

  void _showSaveOptions(Uint8List bytes) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: 24.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_l10n.save, style: _theme.textTheme.titleLarge),
            24.height,
            AppFilledButton(
              text: _l10n.createNewImage,
              onPressed: () {
                Navigator.pop(context);
                _cubit.save(bytes: bytes, isReplace: false);
              },
            ),
            12.height,
            AppFilledButton(
              text: _l10n.replaceOriginal,
              onPressed: () {
                Navigator.pop(context);
                _cubit.save(bytes: bytes, isReplace: true);
              },
            ),
            12.height,
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(_l10n.success),
        content: Text(_l10n.imageSaved),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cubit.pickImage();
            },
            child: Text(_l10n.editAnotherPhoto),
          ),
          AppFilledButton(
            text: _l10n.finish,
            onPressed: () {
              Navigator.pop(context);
              _cubit.navigator.safePop();
            },
          ),
        ],
      ),
    );
  }

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
          Text(
            label,
            style: _theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: _theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ImageEditorCubit, ImageEditorState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            if (state.status == LoadStatus.success) {
              _showSuccessDialog();
            } else if (state.status == LoadStatus.failure) {
              AppDialog(context).showError(
                title: _l10n.unknown,
                message: state.errorMessage ?? "",
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ImageEditorCubit, ImageEditorState>(
        builder: (context, state) {
          if (state.selectedImage == null) {
            return AppScaffold(
              title: _l10n.edit,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_search_rounded,
                      size: 80,
                      color: _theme.colorScheme.primary.withValues(alpha: 0.5),
                    ),
                    24.height,
                    Text(
                      _l10n
                          .confirmnoMorePhotosToDelete, // Reusing a string or using a generic one
                      style: _theme.textTheme.bodyLarge,
                    ),
                    24.height,
                    AppFilledButton(
                      text: _l10n.edit,
                      onPressed: () => _cubit.pickImage(),
                    ),
                  ],
                ),
              ),
            );
          }

          return Stack(
            children: [
              ProImageEditor.file(
                File(state.selectedImage!.path),
                key: ValueKey(
                  state.selectedImage!.path,
                ), // Force rebuild on new image
                callbacks: ProImageEditorCallbacks(
                  onImageEditingComplete: (bytes) async {
                    _showSaveOptions(bytes);
                  },
                  onCloseEditor: (_) {
                    _cubit.navigator.safePop();
                  },
                ),
                configs: ProImageEditorConfigs(
                  designMode: ImageEditorDesignMode.cupertino,
                  theme: _theme,
                  mainEditor: MainEditorConfigs(
                    widgets: MainEditorWidgets(
                      appBar: (editor, rebuildStream) {
                        return ReactiveAppbar(
                          stream: rebuildStream,
                          builder: (_) {
                            return CustomAppBar(
                              title: _l10n.edit,
                              onLeadingPressed: () => editor.closeEditor(),
                              actions: [
                                IconButton(
                                  onPressed: editor.canUndo
                                      ? editor.undoAction
                                      : null,
                                  icon: Icon(
                                    Icons.undo_rounded,
                                    color: editor.canUndo ? null : Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: editor.canRedo
                                      ? editor.redoAction
                                      : null,
                                  icon: Icon(
                                    Icons.redo_rounded,
                                    color: editor.canRedo ? null : Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: AppFilledButton(
                                    text: _l10n.save,
                                    onPressed: () => editor.doneEditing(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      bottomBar: (editor, rebuildStream, key) {
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
                                filter: ImageFilter.blur(
                                  sigmaX: 16,
                                  sigmaY: 16,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: isDark
                                          ? [
                                              const Color(0xCC09161B),
                                              const Color(0xB3153035),
                                            ]
                                          : [
                                              Colors.white.withValues(
                                                alpha: 0.78,
                                              ),
                                              const Color(0xD8E4FFF7),
                                            ],
                                    ),
                                    border: Border(
                                      top: BorderSide(
                                        color: isDark
                                            ? AppColors.glassStroke
                                            : _theme.colorScheme.secondary
                                                  .withValues(alpha: 0.28),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildToolButton(
                                          icon: Icons.format_paint_rounded,
                                          label: "Paint",
                                          onPressed: () =>
                                              editor.openPaintEditor(),
                                        ),
                                        _buildToolButton(
                                          icon: Icons.text_fields_rounded,
                                          label: "Text",
                                          onPressed: () =>
                                              editor.openTextEditor(),
                                        ),
                                        _buildToolButton(
                                          icon: Icons.crop_rotate_rounded,
                                          label: "Crop",
                                          onPressed: () =>
                                              editor.openCropRotateEditor(),
                                        ),
                                        _buildToolButton(
                                          icon: Icons.filter_b_and_w_rounded,
                                          label: "Filter",
                                          onPressed: () =>
                                              editor.openFilterEditor(),
                                        ),
                                        _buildToolButton(
                                          icon: Icons.tune_rounded,
                                          label: "Tune",
                                          onPressed: () =>
                                              editor.openTuneEditor(),
                                        ),
                                        _buildToolButton(
                                          icon: Icons.blur_on_rounded,
                                          label: "Blur",
                                          onPressed: () =>
                                              editor.openBlurEditor(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (state.status == LoadStatus.loading)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        16.height,
                        Text(
                          _l10n.saving,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
