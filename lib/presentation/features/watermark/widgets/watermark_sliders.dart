import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';

class WatermarkSliders extends StatelessWidget {
  final WatermarkState state;
  final WatermarkCubit cubit;
  final bool enabled;

  const WatermarkSliders({
    super.key,
    required this.state,
    required this.cubit,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final textColor = enabled ? null : theme.disabledColor;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.opacity,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.5,
              child: Slider(
                value: state.opacity,
                onChanged: enabled ? cubit.onOpacityChanged : null,
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                '${(state.opacity * 100).toInt()}%',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.size,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.5,
              child: Slider(
                value: state.scale,
                min: 0.5,
                max: 2.0,
                onChanged: enabled ? cubit.onScaleChanged : null,
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                '${(state.scale * 100).toInt()}%',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.density,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.5,
              child: Slider(
                value: state.density.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: enabled ? cubit.onDensityChanged : null,
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                '${state.density}',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
