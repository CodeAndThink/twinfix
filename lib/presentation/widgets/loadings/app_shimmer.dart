import 'package:flutter/material.dart';

class AppShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const AppShimmer({super.key, required this.child, this.enabled = true});

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (isDark ? Colors.grey[800]! : Colors.grey[300]!).withValues(
                  alpha: 0.8,
                ),
                (isDark ? Colors.grey[700]! : Colors.grey[100]!).withValues(
                  alpha: 0.9,
                ),
                (isDark ? Colors.grey[800]! : Colors.grey[300]!).withValues(
                  alpha: 0.8,
                ),
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent - 0.5) * 3,
      0.0,
      0.0,
    );
  }
}

class AppShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isCircle;
  final EdgeInsetsGeometry? margin;

  const AppShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            isCircle ? null : BorderRadius.circular(borderRadius ?? 12),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
