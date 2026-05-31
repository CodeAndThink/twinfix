import 'package:flutter/material.dart';
import 'app_loading.dart';

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: const Center(child: AppLoading()),
    );
  }
}
