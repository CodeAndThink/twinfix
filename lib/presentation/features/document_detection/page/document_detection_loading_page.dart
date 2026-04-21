import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';

class DocumentDetectionLoadingPage extends StatelessWidget {
  const DocumentDetectionLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: 12.paddingAll,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 15, // Mock items for shimmer
              itemBuilder: (context, index) {
                return const AppShimmerBox(borderRadius: 12);
              },
            ),
          ),
        ],
      ),
    );
  }
}
