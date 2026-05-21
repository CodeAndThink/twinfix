import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/loadings/app_shimmer.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class ProfileSettingsLoadingPage extends StatelessWidget {
  const ProfileSettingsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: '',
      body: AppShimmer(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section
              Padding(
                padding: 12.paddingAll,
                child: Center(
                  child: Column(
                    children: [
                      const AppShimmerBox(
                        height: 120,
                        width: 120,
                        isCircle: true,
                      ),
                      8.height,
                      const AppShimmerBox(width: 100, height: 20),
                    ],
                  ),
                ),
              ),
              24.height,
              // Content Section
              Expanded(
                child: AppTransparentContainer(
                  padding: 12.paddingHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // General Header
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: AppShimmerBox(width: 80, height: 24),
                      ),
                      // Information Fields
                      const AppShimmerBox(height: 56, borderRadius: 16),
                      12.height,
                      const AppShimmerBox(height: 56, borderRadius: 16),
                      24.height,
                      // Security Header
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: AppShimmerBox(width: 80, height: 24),
                      ),
                      // Security Row
                      const AppShimmerBox(height: 48, borderRadius: 12),
                      const Spacer(),
                      12.height,
                      // Bottom Button
                      SafeArea(
                        child: Padding(
                          padding: 12.paddingAll,
                          child: const AppShimmerBox(
                            height: 48,
                            width: double.infinity,
                            borderRadius: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
