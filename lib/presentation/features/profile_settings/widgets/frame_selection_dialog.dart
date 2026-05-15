import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class FrameSelectionDialog extends StatelessWidget {
  final AvatarFrameType currentFrameType;
  final Function(AvatarFrameType) onFrameSelected;

  const FrameSelectionDialog({
    super.key,
    required this.currentFrameType,
    required this.onFrameSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
      child: Padding(
        padding: 20.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.selectFrame,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            20.height,
            SizedBox(
              width: double.maxFinite,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: AvatarFrameType.values.length,
                itemBuilder: (context, index) {
                  final frame = AvatarFrameType.fromId(index);
                  final isSelected = currentFrameType == frame;
                  return GestureDetector(
                    onTap: () {
                      onFrameSelected(frame);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: frame.color, width: 4),
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.2,
                                  )
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: theme.colorScheme.primary,
                                )
                              : null,
                        ),
                        4.height,
                        Text(frame.name, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  );
                },
              ),
            ),
            20.height,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
