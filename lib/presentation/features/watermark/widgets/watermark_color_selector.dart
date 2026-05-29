import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';

class WatermarkColorSelector extends StatelessWidget {
  final WatermarkState state;
  final WatermarkCubit cubit;
  final bool enabled;

  const WatermarkColorSelector({
    super.key,
    required this.state,
    required this.cubit,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: AppColors.watermarkColors.length,
          separatorBuilder: (context, index) => 8.width,
          itemBuilder: (context, index) {
            final color = AppColors.watermarkColors[index];
            final isSelected = state.textColor == color;
            return GestureDetector(
              onTap: enabled ? () => cubit.onTextColorChanged(color) : null,
              child: Opacity(
                opacity: enabled ? 1.0 : 0.3,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.grey.withValues(alpha: 0.5),
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
