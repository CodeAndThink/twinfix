import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_cubit.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/navigator/face_blur_navigator.dart';
import 'package:twinfix/presentation/features/face_blur/widgets/face_overlay_widget.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

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
        photoRepository: locator<PhotoRepository>(),
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
  late final ImageProvider _imageProvider;

  @override
  void initState() {
    super.initState();
    _imageProvider = FileImage(File(widget.args.image.path));
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
      // Wait a frame for UI to update
      await Future.delayed(100.milliseconds);

      final boundary =
          _repaintBoundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;

      final ui.Image capturedImage = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await capturedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception(_l10n.convertImageFailed);
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      _cubit.saveImage(pngBytes);
    } catch (e) {
      if (mounted) {
        _cubit.navigator.notify.showError(message: _l10n.error(e.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.blurFace,
      actions: [
        BlocBuilder<FaceBlurCubit, FaceBlurState>(
          buildWhen: (previous, current) =>
              current.saveStatus != previous.saveStatus,
          builder: (context, state) {
            return AppFilledButton(
              isLoading: state.saveStatus.isLoading,
              onPressed: state.saveStatus.isLoading ? null : _saveImage,
              text: _l10n.save,
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FaceBlurCubit, FaceBlurState>(
      buildWhen: (previous, current) =>
          current.analyzeStatus != previous.analyzeStatus ||
          previous.error != current.error ||
          previous.faces != current.faces,
      builder: (context, state) {
        if (state.analyzeStatus.isLoading) {
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
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: AppFileImage(
                                    path: widget.args.image.path,
                                    fit: BoxFit.contain,
                                    width: state.imageSize!.width,
                                    height: state.imageSize!.height,
                                  ),
                                ),
                              ),
                              if (state.faces.isNotEmpty) ...[
                                BlocBuilder<FaceBlurCubit, FaceBlurState>(
                                  buildWhen: (previous, current) =>
                                      previous.faces != current.faces ||
                                      previous.coverStyle !=
                                          current.coverStyle ||
                                      previous.intensity != current.intensity ||
                                      previous.opacity != current.opacity ||
                                      previous.sizeFactor !=
                                          current.sizeFactor ||
                                      previous.emoji != current.emoji,
                                  builder: (context, state) {
                                    return Stack(
                                      children: [
                                        ...state.faces.asMap().entries.map((
                                          entry,
                                        ) {
                                          final index = entry.key;
                                          final face = entry.value;
                                          // Apply inflation
                                          final inflatedRect = face.rect
                                              .inflate(state.sizeFactor);
                                          return Positioned(
                                            left: inflatedRect.left,
                                            top: inflatedRect.top,
                                            width: inflatedRect.width,
                                            height: inflatedRect.height,
                                            child: FaceOverlayWidget(
                                              imageProvider: _imageProvider,
                                              emoji: state.emoji,
                                              faceRect: face.copyWith(
                                                rect: inflatedRect,
                                              ),
                                              coverStyle: state.coverStyle,
                                              intensity: state.intensity,
                                              opacity: state.opacity,
                                              onTap: () =>
                                                  _cubit.toggleFaceCover(index),
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state.faces.isEmpty && state.analyzeStatus.isSuccess)
              Container(
                width: double.infinity,
                padding: 12.paddingAll,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: 12.borderRadius,
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    12.width,
                    Expanded(
                      child: Text(
                        _l10n.noFacesDetected,
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            _buildBottomPanel(),
          ],
        );
      },
    );
  }

  Widget _buildBottomPanel() {
    return BlocBuilder<FaceBlurCubit, FaceBlurState>(
      buildWhen: (previous, current) =>
          previous.coverStyle != current.coverStyle ||
          previous.intensity != current.intensity ||
          previous.opacity != current.opacity ||
          previous.sizeFactor != current.sizeFactor ||
          previous.emoji != current.emoji ||
          previous.faces != current.faces,
      builder: (context, state) {
        return AppTransparentContainer(
          border: 28.borderRadiusTop,
          width: double.infinity,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!state.coverStyle.isFixed && state.faces.isNotEmpty)
                  _buildSliders(state),
                12.height,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: 16.paddingHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: FaceCoverType.values.map((style) {
                      final isSelected = state.coverStyle == style;
                      return GestureDetector(
                        onTap: () => _cubit.changeCoverStyle(style: style),
                        child: Container(
                          margin: 8.paddingRight,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _theme.colorScheme.primary
                                : Colors.grey.withValues(alpha: 0.1),
                            borderRadius: 24.borderRadius,
                          ),
                          child: Text(
                            style.title,
                            style: _theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSliders(FaceBlurState state) {
    return Padding(
      padding: 12.paddingHorizontal,
      child: Column(
        children: [
          if (state.coverStyle.isEmoji) ...[
            AppTransparentContainer(
              onTap: _cubit.setEmoji,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 16,
              child: Row(
                children: [
                  // Emoji Preview Circle
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _theme.colorScheme.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _theme.colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        state.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _l10n.selectEmoji,
                          style: _theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _l10n.tapToChangeStyle,
                          style: _theme.textTheme.bodySmall?.copyWith(
                            color: _theme.textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit Icon indicator
                  Icon(
                    Icons.chevron_right_rounded,
                    color: _theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            12.height,
          ],
          // Size slider (To nhỏ)
          _buildSliderRow(
            label: _l10n.size,
            value: state.sizeFactor,
            min: 0,
            max: 100,
            onChanged: (val) => _cubit.setSizeFactor(val),
          ),
          if (state.coverStyle.isAdjustable) ...[
            8.height,
            // Intensity slider (Đậm nhạt)
            _buildSliderRow(
              label: _l10n.intensity,
              value: state.coverStyle.isSolid ? state.opacity : state.intensity,
              min: 0,
              max: state.coverStyle.isSolid ? 1.0 : 50.0,
              onChanged: (val) {
                if (state.coverStyle.isSolid) {
                  _cubit.setOpacity(val);
                } else {
                  _cubit.setIntensity(val);
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label, style: _theme.textTheme.bodySmall),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
            activeColor: _theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
