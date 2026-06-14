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
          Expanded(
            child: Padding(
              padding: 12.paddingAll,
              child: const AppShimmerBox(
                width: double.infinity,
                borderRadius: 24,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: 8.paddingHorizontal,
              child: Row(
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      const AppShimmerBox(width: 24, height: 24),
                      const AppShimmerBox(width: 80, height: 20),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    spacing: 4,
                    children: [
                      const AppShimmerBox(width: 80, height: 20),
                      const AppShimmerBox(width: 24, height: 24),
                    ],
                  ),
                ],
              ),
            ),
          ),
          12.height,
          Padding(
            padding: 16.paddingHorizontal,
            child: const AppShimmerBox(
              width: double.infinity,
              height: 48,
              borderRadius: 30,
            ),
          ),
          12.height,
        ],
      ),
    );
  }
}
