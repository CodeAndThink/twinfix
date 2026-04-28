import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class DocumentDetectionLoadingPage extends StatelessWidget {
  const DocumentDetectionLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            child: Lottie.asset(
              AppAssets.textScanAnimation,
              width: size.width * 0.7,
              height: size.width * 0.7,
              fit: BoxFit.contain,
              frameRate: FrameRate.max,
            ),
          ),
          24.height,
          Text(
            l10n.scanningDocument,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
