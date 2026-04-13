import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/permission_service.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/extensions.dart';
import '../widgets/scan_mode_selector.dart';
import '../navigator/scan_navigator.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanCubit(
        getPhotosUseCase: locator(),
        userRepository: locator(),
        globalAppCubit: locator(),
        navigator: ScanNavigator(context),
      ),
      child: const ScanChildPage(),
    );
  }
}

class ScanChildPage extends StatefulWidget {
  const ScanChildPage({super.key});

  @override
  State<ScanChildPage> createState() => _ScanChildPageState();
}

class _ScanChildPageState extends State<ScanChildPage> {
  late final ScanCubit _cubit;
  final PermissionService _permissionService = locator<PermissionService>();
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanCubit>();
  }

  Future<void> _checkPermissionAndScan() async {
    final hasPerm = await _permissionService.requestPhotoPermission();
    if (hasPerm) {
      _cubit.startScan();
    } else {
      // Logic handle permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.appName,
      isBack: false,
      isShowAppBar: false,
      body: BlocBuilder<ScanCubit, ScanState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.progress != current.progress ||
            previous.duplicates.length != current.duplicates.length,
        builder: (context, state) {
          if (state.status.isInitial) {
            return _buildInitialUI();
          }

          return Column(
            children: [
              // Content Area
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitialUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large Central Button (Pulse Effect)
          GestureDetector(
            onTap: _checkPermissionAndScan,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                border: Border.all(color: _theme.colorScheme.primary, width: 4),
              ),
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.pets,
                    size: 80,
                    color: _theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          AppSizes.s40.height,

          BlocBuilder<ScanCubit, ScanState>(
            buildWhen: (previous, current) =>
                previous.currentMode != current.currentMode,
            builder: (context, state) {
              return ScanModeSelector(
                currentMode: state.currentMode,
                onModeChanged: (mode) => _cubit.switchMode(mode: mode),
                quickScanLabel: _l10n.quickScan,
                deepScanLabel: _l10n.deepScan,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMascot(ScanState state) {
    IconData iconData = Icons.pets;
    Color iconColor = _theme.colorScheme.primary;

    if (state.status.isLoading) {
      iconData = Icons.search;
    } else if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        iconData = Icons.check_circle;
        iconColor = Colors.green;
      } else {
        iconData = Icons.photo_library;
      }
    }

    return Container(
      width: AppSizes.mascotSize,
      height: AppSizes.mascotSize,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 80, color: iconColor),
    );
  }

  Widget _buildContent(ScanState state) {
    if (state.status.isLoading) {
      return Center(
        child: Padding(
          padding: AppSizes.s32.paddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMascot(state),
              AppSizes.s32.height,
              ClipRRect(
                borderRadius: AppSizes.borderRadius.borderRadius,
                child: LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 12,
                  backgroundColor: _theme.colorScheme.primaryContainer
                      .withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _theme.colorScheme.primary,
                  ),
                ),
              ),
              AppSizes.s12.height,
              Text(
                "${(state.progress * 100).toInt()}%",
                style: _theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _theme.colorScheme.primary,
                ),
              ),
              AppSizes.s8.height,
              Text(_l10n.scanningDevice, style: _theme.textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }

    if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        return _buildEmptyUI();
      }
      // If we are back here with duplicates (success state), show initial UI
      return _buildInitialUI();
    }

    if (state.status.isFailure) {
      return Center(
        child: Text(
          _l10n.error(state.errorMessage ?? ""),
          style: _theme.textTheme.bodyMedium?.copyWith(
            color: _theme.colorScheme.error,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _l10n.perfect,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
          AppSizes.s8.height,
          Text(_l10n.deviceIsClean),
          AppSizes.s32.height,
          ElevatedButton(
            onPressed: () => _cubit.reset(),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }
}
