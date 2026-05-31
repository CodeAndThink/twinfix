import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/models/watermark_template.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_painter.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

class WatermarkTemplateSelector extends StatelessWidget {
  final WatermarkState state;
  final WatermarkCubit cubit;
  final bool enabled;

  const WatermarkTemplateSelector({
    super.key,
    required this.state,
    required this.cubit,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final templates = WatermarkTemplate.defaultTemplates;

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        separatorBuilder: (context, index) => 12.width,
        itemBuilder: (context, index) {
          final isSelected = state.selectedTemplateIndex == index;
          return GestureDetector(
            onTap: enabled ? () => cubit.onTemplateSelected(index) : null,
            child: AnimatedContainer(
              duration: 200.milliseconds,
              width: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: 16.borderRadius),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: enabled ? (isSelected ? 1 : 0.5) : 0.3,
                    child: AppAssetImage(path: AppAssets.bgTemplateWatermark),
                  ),
                  Center(
                    child: Padding(
                      padding: 4.paddingAll,
                      child: Opacity(
                        opacity: enabled ? 1.0 : 0.3,
                        child: CustomPaint(
                          size: const Size(80, 80),
                          painter: WatermarkPainter(
                            text: templates[index].name,
                            opacity: 1.0,
                            scale: 1.0,
                            density: 1,
                            template: templates[index],
                            isPreview: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: 16.borderRadius,
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(
                            alpha: enabled ? (isSelected ? 1 : 0.2) : 0.1,
                          ),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
