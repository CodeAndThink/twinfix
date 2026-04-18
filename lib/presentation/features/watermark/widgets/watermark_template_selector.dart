import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/models/watermark_template.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_painter.dart';

class WatermarkTemplateSelector extends StatelessWidget {
  final WatermarkState state;
  final WatermarkCubit cubit;

  const WatermarkTemplateSelector({
    super.key,
    required this.state,
    required this.cubit,
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
            onTap: () => cubit.onTemplateSelected(index),
            child: AnimatedContainer(
              duration: 200.milliseconds,
              width: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: 16.borderRadius,
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/watermarks/preview_bg.png',
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
