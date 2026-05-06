import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/scan_loading/cubit/scan_loading_cubit.dart';
import 'package:twinfix/presentation/features/scan_loading/cubit/scan_loading_state.dart';
import 'package:twinfix/presentation/features/scan_loading/navigator/scan_loading_navigator.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class ScanLoadingPage extends StatelessWidget {
  const ScanLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanLoadingCubit(
        getPhotosUseCase: locator(),
        navigator: ScanLoadingNavigator(context),
      ),
      child: const ScanLoadingChildPage(),
    );
  }
}

class ScanLoadingChildPage extends StatefulWidget {
  const ScanLoadingChildPage({super.key});

  @override
  State<ScanLoadingChildPage> createState() => _ScanLoadingChildPageState();
}

class _ScanLoadingChildPageState extends State<ScanLoadingChildPage> {
  late final ScanLoadingCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanLoadingCubit>();
    _cubit.startScan();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      title: _l10n.tabScan,
      body: BlocBuilder<ScanLoadingCubit, ScanLoadingState>(
        builder: (context, state) {
          if (state.status.isSuccess && state.duplicates.isEmpty) {
            return _buildEmptyUI();
          }

          if (state.status.isFailure) {
            return _buildFailureUI(error: state.errorMessage);
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
                  style: _theme.textTheme.titleMedium?.copyWith(
                    color: _theme.colorScheme.primary,
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
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      color: _theme.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 52,
            color: _theme.colorScheme.primary,
          ),
          16.height,
          Text(
            _l10n.perfect,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: _theme.colorScheme.primary,
            ),
          ),
          8.height,
          Text(
            _l10n.deviceIsClean,
            textAlign: TextAlign.center,
            style: _theme.textTheme.bodyMedium,
          ),
          24.height,
          ElevatedButton(
            onPressed: () => _cubit.navigator.safePop(),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureUI({String? error}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _l10n.error(error ?? ""),
            style: _theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          24.height,
          ElevatedButton(
            onPressed: () => _cubit.navigator.safePop(),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }
}
