import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/document_detection/cubit/document_detection_cubit.dart';
import 'package:twinfix/presentation/features/document_detection/cubit/document_detection_state.dart';

class DocumentDetectionLoadingPage extends StatelessWidget {
  const DocumentDetectionLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Center(
      child: BlocBuilder<DocumentDetectionCubit, DocumentDetectionState>(
        buildWhen: (previous, current) =>
            previous.scanProgress != current.scanProgress ||
            previous.scanTotal != current.scanTotal,
        builder: (context, state) {
          return Column(
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
              8.height,
              if (state.scanTotal > 0) ...[
                Padding(
                  padding: 48.paddingHorizontal,
                  child: LinearProgressIndicator(
                    value: state.scanProgress / state.scanTotal,
                    borderRadius: 8.borderRadius,
                    minHeight: 8,
                  ),
                ),
                8.height,
                Text(
                  '${state.scanProgress}/${state.scanTotal}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
