import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class AchievementLoadingPage extends StatelessWidget {
  const AchievementLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 100, height: 24),
            ),
            // Progress Card
            const AppShimmerBox(height: 180, borderRadius: 16),

            // Stats Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 80, height: 24),
            ),
            // Stats Row
            Row(
              children: [
                Expanded(child: AppShimmerBox(height: 125, borderRadius: 16)),
                12.width,
                Expanded(child: AppShimmerBox(height: 125, borderRadius: 16)),
              ],
            ),

            // Badges Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 90, height: 24),
            ),
            // Badges Section
            const AppShimmerBox(height: 180, borderRadius: 16),

            // Activity Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 110, height: 24),
            ),
            // Activity Section
            const AppShimmerBox(height: 220, borderRadius: 16),
          ],
        ),
      ),
    );
  }
}
