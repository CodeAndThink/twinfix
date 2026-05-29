import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class HistoryLoadingPage extends StatelessWidget {
  const HistoryLoadingPage({super.key});

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
            // First time group header (e.g. Today)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 80, height: 24),
            ),
            // First group items
            Column(children: List.generate(3, (index) => _buildShimmerItem())),

            // Second time group header (e.g. Yesterday)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppShimmerBox(width: 100, height: 24),
            ),
            // Second group items
            Column(children: List.generate(2, (index) => _buildShimmerItem())),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
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
            const AppShimmerCircle(size: 44),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppShimmerBox(width: 140, height: 16),
                  8.height,
                  const AppShimmerBox(width: 90, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
