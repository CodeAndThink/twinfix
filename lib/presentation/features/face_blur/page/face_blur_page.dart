import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_cubit.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/navigator/face_blur_navigator.dart';
import 'package:twinfix/presentation/features/face_blur/widgets/face_overlay_widget.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

class FaceBlurPageArgs {
  final XFile image;
  const FaceBlurPageArgs({required this.image});
}

class FaceBlurPage extends StatelessWidget {
  final FaceBlurPageArgs args;

  const FaceBlurPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaceBlurCubit(
        navigator: FaceBlurNavigator(context),
        imageFile: args.image,
      ),
      child: FaceBlurChildPage(args: args),
    );
  }
}

class FaceBlurChildPage extends StatefulWidget {
  final FaceBlurPageArgs args;

  const FaceBlurChildPage({super.key, required this.args});

  @override
  State<FaceBlurChildPage> createState() => _FaceBlurChildPageState();
}

class _FaceBlurChildPageState extends State<FaceBlurChildPage> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  late FaceBlurCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FaceBlurCubit>();
    _cubit.detectFaces();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _saveImage() async {
    try {
      _cubit.setSaving(true);

      // Wait a frame for UI to update (in case we hide UI elements, though here we want exactly the boundary)
      await Future.delayed(100.milliseconds);

      final boundary =
          _repaintBoundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;

      // Note: For large images, we might need to specify pixel ratio or scale.
      // We will capture it at device pixel ratio or 1.0 since it's already full original size inside FittedBox.
      final ui.Image capturedImage = await boundary.toImage(pixelRatio: 1.0);
      final ByteData? byteData = await capturedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception("Failed to convert image");
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Request permission
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth || ps == PermissionState.limited) {
        await PhotoManager.editor.saveImage(
          pngBytes,
          filename:
              "twinfix_faceblur_${DateTime.now().millisecondsSinceEpoch}.png",
        );

        if (mounted) {
          _cubit.navigator.notify.showSuccess(message: _l10n.imageSaved);
        }
      } else {
        if (mounted) {
          _cubit.navigator.notify.showError(
            message: _l10n.error("Permission Denied"),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _cubit.navigator.notify.showError(message: _l10n.error(e.toString()));
      }
    } finally {
      if (mounted) _cubit.setSaving(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = _l10n;
    _theme = Theme.of(context);

    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: _l10n.blurFace,
      actions: [
        BlocBuilder<FaceBlurCubit, FaceBlurState>(
          buildWhen: (previous, current) => current.isSaving,
          builder: (context, state) {
            if (state.isLoading || state.imageSize == null) {
              return const SizedBox.shrink();
            }

            return TextButton(
              onPressed: state.isSaving ? null : _saveImage,
              child: state.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _l10n.save,
                      style: _theme.textTheme.titleSmall?.copyWith(
                        color: _theme.colorScheme.onPrimary,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FaceBlurCubit, FaceBlurState>(
      buildWhen: (previous, current) =>
          current.isLoading ||
          current.imageSize == null ||
          current.error != null,
      builder: (context, state) {
        if (state.isLoading || state.imageSize == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text(state.error!));
        }

        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: RepaintBoundary(
                        key: _repaintBoundaryKey,
                        child: SizedBox(
                          width: state.imageSize!.width,
                          height: state.imageSize!.height,
                          child: Stack(
                            children: [
                              AppAssetImage(
                                path: widget.args.image.path,
                                fit: BoxFit.contain,
                                width: state.imageSize!.width,
                                height: state.imageSize!.height,
                              ),

                              ...state.faces.asMap().entries.map((entry) {
                                final index = entry.key;
                                final face = entry.value;
                                return Positioned(
                                  left: face.rect.left,
                                  top: face.rect.top,
                                  width: face.rect.width,
                                  height: face.rect.height,
                                  child: FaceOverlayWidget(
                                    faceRect: face,
                                    coverStyle: state.coverStyle,
                                    onTap: () => _cubit.toggleFaceCover(index),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildBottomPanel(state),
          ],
        );
      },
    );
  }

  Widget _buildBottomPanel(FaceBlurState state) {
    // Determine translation or fallback
    String getEffectLabel(FaceCoverStyle style) {
      try {
        switch (style) {
          case FaceCoverStyle.blur:
            return "Blur";
          case FaceCoverStyle.pixelate:
            return "Pixelate";
          case FaceCoverStyle.solid:
            return "Solid Color";
          case FaceCoverStyle.emoji:
            return "Emoji";
        }
      } catch (e) {
        return style.name;
      }
    }

    return Container(
      color: _theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: FaceCoverStyle.values.map((style) {
              final isSelected = state.coverStyle == style;
              return GestureDetector(
                onTap: () => _cubit.changeCoverStyle(style),
                child: Container(
                  margin: 12.paddingRight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _theme.colorScheme.primary
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: 24.borderRadius,
                    border: Border.all(
                      color: isSelected
                          ? _theme.colorScheme.primary
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    getEffectLabel(style),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : _theme.textTheme.bodyMedium?.color,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
