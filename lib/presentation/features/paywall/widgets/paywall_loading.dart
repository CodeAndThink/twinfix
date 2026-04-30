import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class PaywallLoading extends StatelessWidget {
  const PaywallLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppShimmer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 40),
        children: [
          // Header section
          Center(
            child: Column(
              children: [
                const AppShimmerCircle(size: 100),
                24.height,
                const AppShimmerBox(height: 28, width: 200),
                8.height,
                const AppShimmerBox(height: 16, width: 280),
              ],
            ),
          ),
          40.height,

          // Features title
          const AppShimmerBox(height: 20, width: 120),
          20.height,

          // Benefit rows
          for (int i = 0; i < 3; i++) ...[
            const AppShimmerBox(height: 24, width: double.infinity),
            12.height,
          ],
          40.height,

          // Package cards
          Container(
            padding: 20.padding,
            decoration: BoxDecoration(
              borderRadius: 20.borderRadius,
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppShimmerBox(height: 20, width: 100),
                      4.height,
                      const AppShimmerBox(height: 14, width: 180),
                    ],
                  ),
                ),
                const AppShimmerBox(height: 28, width: 80),
              ],
            ),
          ),
          16.height,

          Container(
            padding: 20.padding,
            decoration: BoxDecoration(
              borderRadius: 20.borderRadius,
              border: Border.all(color: theme.colorScheme.primary),
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppShimmerBox(height: 20, width: 120),
                      4.height,
                      const AppShimmerBox(height: 14, width: 160),
                    ],
                  ),
                ),
                const AppShimmerBox(height: 28, width: 80),
              ],
            ),
          ),
          32.height,

          // Bottom buttons
          Center(
            child: Column(
              children: [
                const AppShimmerBox(height: 20, width: 180),
                8.height,
                const AppShimmerBox(height: 20, width: 140),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
