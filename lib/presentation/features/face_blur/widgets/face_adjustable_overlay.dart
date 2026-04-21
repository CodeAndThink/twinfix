import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:twinfix/core/enums/face_cover_type.dart';
import 'package:twinfix/presentation/features/face_blur/cubit/face_blur_state.dart';

class FaceAdjustableOverlay extends StatelessWidget {
  final ImageProvider imageProvider;
  final FaceRect faceRect;
  final FaceCoverType coverStyle;
  final double intensity;
  final double opacity;
  final VoidCallback onTap;

  const FaceAdjustableOverlay({
    super.key,
    required this.imageProvider,
    required this.faceRect,
    required this.coverStyle,
    required this.intensity,
    required this.opacity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (coverStyle) {
      case FaceCoverType.blur:
        child = ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: intensity, sigmaY: intensity),
            child: Container(color: Colors.transparent),
          ),
        );
        break;
      case FaceCoverType.pixelate:
        child = ClipOval(
          child: ImagePixels(
            imageProvider: imageProvider,
            builder: (context, img) {
              return CustomPaint(
                size: Size(faceRect.rect.width, faceRect.rect.height),
                painter: PixelatePainter(
                  img: img,
                  faceRect: faceRect.rect,
                  pixelSize: (intensity / 2).clamp(2.0, 50.0),
                  opacity: opacity,
                ),
              );
            },
          ),
        );
        break;
      case FaceCoverType.solid:
        child = Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: opacity),
            shape: BoxShape.circle,
          ),
        );
        break;
      default:
        child = const SizedBox.shrink();
    }

    return GestureDetector(onTap: onTap, child: child);
  }
}

class PixelatePainter extends CustomPainter {
  final ImgDetails img;
  final Rect faceRect;
  final double pixelSize;
  final double opacity;

  PixelatePainter({
    required this.img,
    required this.faceRect,
    required this.pixelSize,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!img.hasImage) return;

    final paint = Paint()..style = PaintingStyle.fill;

    for (double y = 0; y < size.height; y += pixelSize) {
      for (double x = 0; x < size.width; x += pixelSize) {
        // Sample color from the center of the pixel block
        final int sampleX = (faceRect.left + x + pixelSize / 2).toInt();
        final int sampleY = (faceRect.top + y + pixelSize / 2).toInt();

        final color = img.pixelColorAt!(sampleX, sampleY);
        paint.color = color.withValues(alpha: color.a * opacity);

        canvas.drawRect(Rect.fromLTWH(x, y, pixelSize, pixelSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PixelatePainter oldDelegate) {
    return oldDelegate.pixelSize != pixelSize ||
        oldDelegate.img != img ||
        oldDelegate.opacity != opacity;
  }
}
