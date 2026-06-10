import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/media_timeline/cubit/media_timeline_state.dart';

class MediaTimelineSegmentButton extends StatelessWidget {
  final TimelineMode selectedMode;
  final ValueChanged<TimelineMode> onChanged;
  final String dayLabel;
  final String monthLabel;
  final String yearLabel;

  const MediaTimelineSegmentButton({
    super.key,
    required this.selectedMode,
    required this.onChanged,
    required this.dayLabel,
    required this.monthLabel,
    required this.yearLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: 4.paddingAll,
      child: Row(
        children: [
          _buildSegment(context, TimelineMode.day, dayLabel),
          _buildSegment(context, TimelineMode.month, monthLabel),
          _buildSegment(context, TimelineMode.year, yearLabel),
        ],
      ),
    );
  }

  Widget _buildSegment(BuildContext context, TimelineMode mode, String label) {
    final theme = Theme.of(context);
    final isSelected = selectedMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isSelected) onChanged(mode);
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: 200.milliseconds,
          padding: 10.paddingVertical,
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: 28.borderRadius,
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
