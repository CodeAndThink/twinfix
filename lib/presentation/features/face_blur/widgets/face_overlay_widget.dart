import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';
import 'package:twinfix/presentation/features/face_blur/widgets/face_adjustable_overlay.dart';
import 'package:twinfix/presentation/features/face_blur/widgets/face_coordinate_overlay.dart';
import 'package:twinfix/presentation/features/face_blur/widgets/face_emoji_overlay.dart';

class FaceOverlayWidget extends StatelessWidget {
  final FaceRect faceRect;
  final FaceCoverType coverStyle;
  final double intensity;
  final double opacity;
  final String emoji;
  final VoidCallback onTap;
  final ImageProvider imageProvider;

  const FaceOverlayWidget({
    super.key,
    required this.faceRect,
    required this.coverStyle,
    required this.intensity,
    required this.opacity,
    required this.onTap,
    required this.emoji,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    if (!faceRect.isEnabled) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent, // Ensure it's tappable
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
              ),
              ...faceRect.landmarks.values.map((pos) {
                final localPos = pos - faceRect.rect.topLeft;
                return Positioned(
                  left: localPos.dx - 2,
                  top: localPos.dy - 2,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    }

    if (coverStyle.isAdjustable) {
      return FaceAdjustableOverlay(
        imageProvider: imageProvider,
        faceRect: faceRect,
        coverStyle: coverStyle,
        intensity: intensity,
        opacity: opacity,
        onTap: onTap,
      );
    }

    if (coverStyle.isEmojiStyle) {
      return FaceEmojiOverlay(
        faceRect: faceRect,
        opacity: opacity,
        onTap: onTap,
        emoji: emoji,
      );
    }

    if (coverStyle.isFixed) {
      return FaceCoordinateOverlay(
        faceRect: faceRect,
        coverStyle: coverStyle,
        onTap: onTap,
      );
    }

    return const SizedBox.shrink();
  }
}
