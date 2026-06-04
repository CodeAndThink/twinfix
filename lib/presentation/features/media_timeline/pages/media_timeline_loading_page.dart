import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class MediaTimelineLoadingPage extends StatelessWidget {
  const MediaTimelineLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AppShimmerBox(
              height: 40,
              width: double.infinity,
              borderRadius: 20,
            ),
            16.height,
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return const AppShimmerBox(
                    height: 56,
                    width: double.infinity,
                    borderRadius: 12,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
