import 'package:flutter/material.dart';
import 'package:twinfix/presentation/features/watermark/models/watermark_template.dart';

class WatermarkPainter extends CustomPainter {
  final String text;
  final double opacity;
  final double scale;
  final WatermarkTemplate template;
  final int density;
  final bool isPreview;
  final Color? color;

  WatermarkPainter({
    required this.text,
    required this.opacity,
    required this.scale,
    required this.density,
    required this.template,
    this.isPreview = false,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (text.isEmpty) return;

    // Calculate resolution scale based on a reference width (e.g., 400 logical pixels)
    // to ensure watermark remains visible on high-resolution images.
    // For previews, we scale down to fit the small thumbnail container (e.g., 80x80).
    final resScale = isPreview ? (size.width / 160) : (size.width / 400);

    final textStyle = template.style.copyWith(
      color: (color ?? template.style.color)?.withValues(alpha: opacity),
      fontSize: (template.style.fontSize ?? 24) * scale * resScale,
    );

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    canvas.save();

    if (!isPreview && density > 1) {
      _paintTiled(canvas, size, textPainter, resScale);
    } else {
      _paintSingle(canvas, size, textPainter, resScale);
    }

    canvas.restore();
  }

  void _paintSingle(
    Canvas canvas,
    Size size,
    TextPainter textPainter,
    double resScale,
  ) {
    Offset offset = Offset.zero;
    final padding = 20 * resScale;

    if (isPreview) {
      offset = Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      );
    } else {
      switch (template.position) {
        case WatermarkPosition.topLeft:
          offset = Offset(padding, padding);
          break;
        case WatermarkPosition.topRight:
          offset = Offset(size.width - textPainter.width - padding, padding);
          break;
        case WatermarkPosition.bottomLeft:
          offset = Offset(padding, size.height - textPainter.height - padding);
          break;
        case WatermarkPosition.bottomRight:
          offset = Offset(
            size.width - textPainter.width - padding,
            size.height - textPainter.height - padding,
          );
          break;
        case WatermarkPosition.center:
          offset = Offset(
            (size.width - textPainter.width) / 2,
            (size.height - textPainter.height) / 2,
          );
          break;
      }
    }

    _drawWatermark(canvas, offset, textPainter, resScale);
  }

  void _paintTiled(
    Canvas canvas,
    Size size,
    TextPainter textPainter,
    double resScale,
  ) {
    final double stepX = size.width / (density + 1);
    final double stepY = size.height / (density + 1);

    for (int i = 1; i <= density; i++) {
      for (int j = 1; j <= density; j++) {
        final offset = Offset(
          i * stepX - (textPainter.width / 2),
          j * stepY - (textPainter.height / 2),
        );
        _drawWatermark(canvas, offset, textPainter, resScale);
      }
    }
  }

  void _drawWatermark(
    Canvas canvas,
    Offset offset,
    TextPainter textPainter,
    double resScale,
  ) {
    canvas.save();
    canvas.translate(
      offset.dx + textPainter.width / 2,
      offset.dy + textPainter.height / 2,
    );
    canvas.rotate(template.angle * 3.1415926535897932 / 180);
    canvas.translate(-textPainter.width / 2, -textPainter.height / 2);

    if (template.hasBackground) {
      final bgPadding = 10 * resScale;
      final rect = Rect.fromLTWH(
        -bgPadding,
        -bgPadding,
        textPainter.width + (bgPadding * 2),
        textPainter.height + (bgPadding * 2),
      );
      final rRect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(8 * resScale),
      );
      canvas.drawRRect(
        rRect,
        Paint()..color = Colors.black.withValues(alpha: opacity * 0.5),
      );
    }

    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WatermarkPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.opacity != opacity ||
        oldDelegate.scale != scale ||
        oldDelegate.density != density ||
        oldDelegate.template != template ||
        oldDelegate.color != color;
  }
}
