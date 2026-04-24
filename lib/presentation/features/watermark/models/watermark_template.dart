import 'package:flutter/material.dart';

enum WatermarkPosition { topLeft, topRight, bottomLeft, bottomRight, center }

class WatermarkTemplate {
  final String name;
  final WatermarkPosition position;
  final TextStyle style;
  final bool hasBackground;
  final double opacity;
  final double angle; // In degrees

  const WatermarkTemplate({
    required this.name,
    required this.position,
    required this.style,
    this.hasBackground = false,
    this.opacity = 1.0,
    this.angle = 0,
  });

  static List<WatermarkTemplate> get defaultTemplates => [
    const WatermarkTemplate(
      name: 'Standard',
      position: WatermarkPosition.bottomRight,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    const WatermarkTemplate(
      name: 'Copyright',
      position: WatermarkPosition.bottomLeft,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 18,
        fontStyle: FontStyle.italic,
      ),
    ),
    const WatermarkTemplate(
      name: 'Minimal',
      position: WatermarkPosition.topRight,
      style: TextStyle(color: Colors.white54, fontSize: 14),
    ),
    const WatermarkTemplate(
      name: 'Outline',
      position: WatermarkPosition.bottomRight,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(offset: Offset(-1, -1), color: Colors.black),
          Shadow(offset: Offset(1, -1), color: Colors.black),
          Shadow(offset: Offset(1, 1), color: Colors.black),
          Shadow(offset: Offset(-1, 1), color: Colors.black),
        ],
      ),
    ),
    const WatermarkTemplate(
      name: 'Glass',
      position: WatermarkPosition.bottomRight,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      hasBackground: true,
    ),
    const WatermarkTemplate(
      name: 'Centered Tilt',
      position: WatermarkPosition.center,
      style: TextStyle(
        color: Colors.white24,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      angle: -45,
    ),
  ];
}
