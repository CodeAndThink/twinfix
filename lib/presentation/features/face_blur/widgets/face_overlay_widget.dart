import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';

class FaceOverlayWidget extends StatelessWidget {
  final FaceRect faceRect;
  final FaceCoverStyle coverStyle;
  final VoidCallback onTap;

  const FaceOverlayWidget({
    super.key,
    required this.faceRect,
    required this.coverStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!faceRect.isEnabled) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 2,
            ),
            borderRadius: 1000.borderRadius,
          ),
        ),
      );
    }

    Widget child;
    switch (coverStyle) {
      case FaceCoverStyle.blur:
        child = ClipRRect(
          borderRadius: 1000.borderRadius, // Circular
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.transparent),
          ),
        );
        break;
      case FaceCoverStyle.pixelate:
        // A simple pixelation effect is not native in Flutter.
        // We'll mimic it using a highly pixelated backdrop filter or image scaling.
        // For simplicity and speed, we can use a very heavy blur or an asset if available.
        // Alternatively, since pixelate filter requires custom shaders, we'll use a mosaic-like pattern.
        child = ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Fallback
            child: Container(color: Colors.grey.withValues(alpha: 0.5)),
          ),
        );
        break;
      case FaceCoverStyle.solid:
        child = Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        );
        break;
      case FaceCoverStyle.emoji:
        child = const FittedBox(child: Text('😎'));
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          // Optional selected border could be shown here.
        ],
      ),
    );
  }
}
