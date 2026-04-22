import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class RemoveGPSLoadingPage extends StatelessWidget {
  const RemoveGPSLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppAssets.radarAnimation,
            width: size.width * 0.7,
            height: size.width * 0.7,
            fit: BoxFit.contain,
          ),
          24.height,
          Text(
            l10n.scanningDevice,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
