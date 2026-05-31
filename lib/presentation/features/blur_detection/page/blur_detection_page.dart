import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/blur_detection/cubit/blur_detection_cubit.dart';
import 'package:twinfix/presentation/features/blur_detection/cubit/blur_detection_state.dart';
import 'package:twinfix/presentation/features/blur_detection/navigator/blur_detection_navigator.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class BlurDetectionPage extends StatelessWidget {
  const BlurDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlurDetectionCubit(
        navigator: BlurDetectionNavigator(context),
        photoRepository: locator(),
      ),
      child: const BlurDetectionChildPage(),
    );
  }
}

class BlurDetectionChildPage extends StatefulWidget {
  const BlurDetectionChildPage({super.key});

  @override
  State<BlurDetectionChildPage> createState() => _BlurDetectionChildPageState();
}

class _BlurDetectionChildPageState extends State<BlurDetectionChildPage> {
  late final BlurDetectionCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<BlurDetectionCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(400.milliseconds);
      if (mounted) {
        _cubit.scan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return BlocListener<BlurDetectionCubit, BlurDetectionState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status.isSuccess,
      listener: (context, state) {
        _cubit.onShowResults();
      },
      child: AppScaffold(title: _l10n.blurryPhotos, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocBuilder<BlurDetectionCubit, BlurDetectionState>(
      builder: (context, state) {
        if (state.status.isFailure) {
          return Center(
            child: Text(
              _l10n.error(state.errorMessage ?? ''),
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                child: Lottie.asset(
                  AppAssets.radarAnimation,
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  fit: BoxFit.contain,
                  frameRate: FrameRate.max,
                ),
              ),
              24.height,
              Text(
                _l10n.scanningDevice,
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
          ),
        );
      },
    );
  }
}
