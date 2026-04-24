import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveValue<int>(
                  context,
                  conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 3),
                    const Condition.largerThan(name: MOBILE, value: 5),
                  ],
                  defaultValue: 3,
                ).value,
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
