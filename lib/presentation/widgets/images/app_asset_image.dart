import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const AppAssetImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: width, height: height, fit: fit);
  }
}
