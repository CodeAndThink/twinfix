import 'package:flutter/material.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';

class FaceEmojiOverlay extends StatelessWidget {
  final FaceRect faceRect;
  final double opacity;
  final String emoji;
  final VoidCallback onTap;

  const FaceEmojiOverlay({
    super.key,
    required this.faceRect,
    required this.opacity,
    required this.onTap,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: FittedBox(fit: BoxFit.contain, child: Text(emoji)),
      ),
    );
  }
}
