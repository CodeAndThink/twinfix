import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class GalleryManagerLoadingPage extends StatelessWidget {
  const GalleryManagerLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          Padding(
            padding: 8.paddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppShimmerBox(width: 80, height: 20),
                const AppShimmerBox(width: 80, height: 20),
              ],
            ),
          ),
          16.height,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: AppShimmerBox(width: double.infinity, borderRadius: 24),
            ),
          ),
          16.height,
          Padding(
            padding: 16.paddingAll,
            child: const AppShimmerBox(width: double.infinity, height: 48),
          ),
        ],
      ),
    );
  }
}
