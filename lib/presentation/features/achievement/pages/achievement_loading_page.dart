import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class AchievementLoadingPage extends StatelessWidget {
  const AchievementLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        padding: 16.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Memory Warning Shimmer (optional, maybe just skip or show small box)
            AppShimmerBox(height: 100, borderRadius: 16),
            24.height,

            // Level Progress Card Shimmer
            Container(
              padding: 24.padding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: 12.borderRadius,
              ),
              child: Column(
                children: [
                  const AppShimmerBox(width: 48, height: 48, isCircle: true),
                  8.height,
                  const AppShimmerBox(width: 120, height: 32),
                  16.height,
                  const AppShimmerBox(width: double.infinity, height: 12),
                  8.height,
                  const AppShimmerBox(width: 180, height: 16),
                ],
              ),
            ),
            24.height,

            // Stats Row Shimmer
            Row(
              children: [
                Expanded(child: AppShimmerBox(height: 120, borderRadius: 16)),
                16.width,
                Expanded(child: AppShimmerBox(height: 120, borderRadius: 16)),
              ],
            ),
            24.height,

            // Badges Section Shimmer
            const AppShimmerBox(width: 100, height: 24),
            16.height,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveValue<int>(
                  context,
                  conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 3),
                    const Condition.largerThan(name: MOBILE, value: 5),
                  ],
                  defaultValue: 3,
                ).value,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Column(
                children: [
                  AppShimmerBox(width: 60, height: 60, isCircle: true),
                  8.height,
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
