import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/models/watermark_template.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_painter.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';

class WatermarkImagePreview extends StatelessWidget {
  final WatermarkState state;

  const WatermarkImagePreview({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final imagePath = state.imagePath;
    if (imagePath == null) return const SizedBox.shrink();

    final template =
        WatermarkTemplate.defaultTemplates[state.selectedTemplateIndex];

    return Center(
      child: AppTransparentContainer(
        padding: 4.paddingAll,
        borderRadius: 12,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: 8.borderRadius,
              child: AppFileImage(path: imagePath, fit: BoxFit.contain),
            ),
            if (state.text.isNotEmpty)
              Positioned.fill(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: WatermarkPainter(
                    text: state.text,
                    opacity: state.opacity,
                    scale: state.scale,
                    density: state.density,
                    template: template,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
