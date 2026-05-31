import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class ActivityDetailLoadingPage extends StatelessWidget {
  const ActivityDetailLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          12,
          MediaQuery.of(context).padding.top,
          12,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contribution Graph Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 140, height: 24),
            ),
            // Contribution Graph Box
            const AppShimmerBox(height: 250, borderRadius: 16),

            // History Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 80, height: 24),
            ),

            // History List Items inside a container
            Column(
              children: List.generate(4, (index) {
                return Padding(
                  padding: 8.paddingBottom,
                  child: Container(
                    padding: 8.paddingAll,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Shimmer Circle for Icon
                        const AppShimmerCircle(size: 44),
                        16.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Deleted items count text placeholder
                              const AppShimmerBox(width: 120, height: 16),
                              8.height,
                              // Date/time text placeholder
                              const AppShimmerBox(width: 80, height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
