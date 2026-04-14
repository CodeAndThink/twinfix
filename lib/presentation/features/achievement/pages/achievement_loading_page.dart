import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class AchievementLoadingPage extends StatelessWidget {
  const AchievementLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        padding: AppSizes.s16.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Memory Warning Shimmer (optional, maybe just skip or show small box)
            AppShimmerBox(height: 100, borderRadius: 16),
            AppSizes.s24.height,

            // Level Progress Card Shimmer
            Container(
              padding: AppSizes.s24.padding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSizes.borderRadius.borderRadius,
              ),
              child: Column(
                children: [
                  const AppShimmerBox(width: 48, height: 48, isCircle: true),
                  AppSizes.s8.height,
                  const AppShimmerBox(width: 120, height: 32),
                  AppSizes.s16.height,
                  const AppShimmerBox(width: double.infinity, height: 12),
                  AppSizes.s8.height,
                  const AppShimmerBox(width: 180, height: 16),
                ],
              ),
            ),
            AppSizes.s24.height,

            // Stats Row Shimmer
            Row(
              children: [
                Expanded(child: AppShimmerBox(height: 120, borderRadius: 16)),
                AppSizes.s16.width,
                Expanded(child: AppShimmerBox(height: 120, borderRadius: 16)),
              ],
            ),
            AppSizes.s24.height,

            // Badges Section Shimmer
            const AppShimmerBox(width: 100, height: 24),
            AppSizes.s16.height,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppSizes.s16,
                mainAxisSpacing: AppSizes.s16,
                childAspectRatio: 0.8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Column(
                children: [
                  AppShimmerBox(width: 60, height: 60, isCircle: true),
                  AppSizes.s8.height,
                  AppShimmerBox(width: 50, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
