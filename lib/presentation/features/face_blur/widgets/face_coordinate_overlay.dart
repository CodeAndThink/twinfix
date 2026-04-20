import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';

class FaceCoordinateOverlay extends StatelessWidget {
  final FaceRect faceRect;
  final FaceCoverType coverStyle;
  final VoidCallback onTap;

  const FaceCoordinateOverlay({
    super.key,
    required this.faceRect,
    required this.coverStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (coverStyle == FaceCoverType.eyeBar) _buildEyeBar(),
          if (coverStyle == FaceCoverType.glasses) _buildGlasses(),
        ],
      ),
    );
  }

  Widget _buildEyeBar() {
    final leftEye = faceRect.landmarks[FaceLandmarkType.leftEye];
    final rightEye = faceRect.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) return const SizedBox.shrink();

    // Calculate local positions
    final Offset p1 = leftEye - faceRect.rect.topLeft;
    final Offset p2 = rightEye - faceRect.rect.topLeft;

    final double distance = (p2 - p1).distance;
    final double angle = math.atan2(p2.dy - p1.dy, p2.dx - p1.dx);
    final Offset midpoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

    final double barWidth = distance * 2.2; // Extra width to cover the eyes
    final double barHeight = faceRect.rect.height * 0.15;

    return Positioned(
      left: midpoint.dx - barWidth / 2,
      top: midpoint.dy - barHeight / 2,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: barWidth,
          height: barHeight,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildGlasses() {
    final leftEye = faceRect.landmarks[FaceLandmarkType.leftEye];
    final rightEye = faceRect.landmarks[FaceLandmarkType.rightEye];

    if (leftEye == null || rightEye == null) return const SizedBox.shrink();

    final Offset p1 = leftEye - faceRect.rect.topLeft;
    final Offset p2 = rightEye - faceRect.rect.topLeft;
    final Offset midpoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
    final double distance = (p2 - p1).distance;
    final double angle = math.atan2(p2.dy - p1.dy, p2.dx - p1.dx);

    return Positioned(
      left: midpoint.dx - distance * 1.5,
      top: midpoint.dy - distance * 1.5,
      width: distance * 3,
      height: distance * 3,
      child: Transform.rotate(
        angle: angle,
        child: const FittedBox(fit: BoxFit.contain, child: Text(' 🕶️')),
      ),
    );
  }
}
