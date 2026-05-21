import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final Widget? errorWidget;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => AppShimmer(
          child: AppShimmerBox(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey.shade100,
              child: const Icon(Icons.error_outline, color: Colors.grey),
            ),
      ),
    );
  }
}
