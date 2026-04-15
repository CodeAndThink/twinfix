import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class ScanTutorialStep {
  final String title;
  final String message;
  final String nextLabel;

  const ScanTutorialStep({
    required this.title,
    required this.message,
    required this.nextLabel,
  });
}

class ScanTutorialOverlay extends StatelessWidget {
  final Rect targetRect;
  final ThemeData theme;
  final ScanTutorialStep step;
  final int currentStepIndex;
  final int totalSteps;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onTargetTap;

  const ScanTutorialOverlay({
    super.key,
    required this.targetRect,
    required this.theme,
    required this.step,
    required this.currentStepIndex,
    required this.totalSteps,
    required this.onSkip,
    required this.onNext,
    required this.onTargetTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final spotlightRect = targetRect.inflate(8);
    final screenSize = MediaQuery.sizeOf(context);
    final showBubbleAbove = spotlightRect.center.dy > screenSize.height * 0.56;
    final bubbleWidth = (screenSize.width - 32).clamp(0, 340).toDouble();
    final bubbleLeft = (spotlightRect.center.dx - (bubbleWidth / 2)).clamp(
      16.0,
      screenSize.width - bubbleWidth - 16,
    );
    final bubbleTop = showBubbleAbove
        ? (spotlightRect.top - 168).clamp(24.0, screenSize.height - 188)
        : (spotlightRect.bottom + 28).clamp(24.0, screenSize.height - 188);
    final arrowTop = showBubbleAbove
        ? spotlightRect.top - 26
        : spotlightRect.bottom + 4;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: CustomPaint(
              painter: _TutorialSpotlightPainter(targetRect: spotlightRect),
            ),
          ),
        ),
        Positioned.fromRect(
          rect: spotlightRect,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: 24.borderRadius,
                border: Border.all(color: theme.colorScheme.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.32),
                    blurRadius: 28,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: spotlightRect.left,
          top: spotlightRect.top,
          width: spotlightRect.width,
          height: spotlightRect.height,
          child: Material(
            color: Colors.transparent,
            child: InkWell(borderRadius: 24.borderRadius, onTap: onTargetTap),
          ),
        ),
        Positioned(
          left: (spotlightRect.center.dx - 18).clamp(
            16.0,
            screenSize.width - 52,
          ),
          top: arrowTop,
          child: Icon(
            showBubbleAbove
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: theme.colorScheme.primary,
            size: 36,
          ),
        ),
        Positioned(
          left: bubbleLeft,
          top: bubbleTop,
          width: bubbleWidth,
          child: ClipRRect(
            borderRadius: 24.borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: 18.paddingAll,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xF20A1D24), Color(0xF214333A)],
                  ),
                  borderRadius: 24.borderRadius,
                  border: Border.all(color: AppColors.glassStroke, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      step.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    8.height,
                    Text(
                      step.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    16.height,
                    Row(
                      children: [
                        Text(
                          '${currentStepIndex + 1}/$totalSteps',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(onPressed: onSkip, child: Text(l10n.skip)),
                        8.width,
                        FilledButton(
                          onPressed: onNext,
                          child: Text(step.nextLabel),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TutorialSpotlightPainter extends CustomPainter {
  final Rect targetRect;

  const _TutorialSpotlightPainter({required this.targetRect});

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPath = Path()..addRect(Offset.zero & size);
    final holePath = Path()
      ..addRRect(RRect.fromRectAndRadius(targetRect, 24.radius));

    final result = Path.combine(
      PathOperation.difference,
      overlayPath,
      holePath,
    );

    canvas.drawPath(
      result,
      Paint()..color = Colors.black.withValues(alpha: 0.72),
    );
  }

  @override
  bool shouldRepaint(covariant _TutorialSpotlightPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect;
  }
}
