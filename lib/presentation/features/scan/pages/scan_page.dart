import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import '../../../../core/di/injection.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/extensions.dart';
import '../navigator/scan_navigator.dart';
import '../widgets/scan_tutorial_overlay.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanCubit(
        getPhotosUseCase: locator(),
        globalAppCubit: locator(),
        sharedPreferences: locator(),
        permissionService: locator(),
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

class _ScanChildPageState extends State<ScanChildPage>
    with SingleTickerProviderStateMixin {
  late final ScanCubit _cubit;
  late final AnimationController _rotationController;

  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanCubit>();
    _cubit.prepareTutorialIfNeeded();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.appName,
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ScanCubit, ScanState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.duplicates.length != current.duplicates.length ||
          previous.isTutorialVisible != current.isTutorialVisible ||
          previous.tutorialStepIndex != current.tutorialStepIndex ||
          previous.tutorialTargetRect != current.tutorialTargetRect,
      builder: (context, state) {
        if (state.isTutorialVisible && state.status.isInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _cubit.updateTutorialTargetRect();
          });
        }

        final Widget content;
        if (state.status.isInitial) {
          content = _buildInitialUI();
        } else {
          content = Column(children: [Expanded(child: _buildContent(state))]);
        }

        return Stack(
          key: _cubit.tutorialStackKey,
          children: [
            Positioned.fill(child: content),
            if (state.isTutorialVisible &&
                state.status.isInitial &&
                state.tutorialTargetRect != null)
              Positioned.fill(
                child: ScanTutorialOverlay(
                  targetRect: state.tutorialTargetRect!,
                  theme: _theme,
                  step: _cubit.tutorialSteps[state.tutorialStepIndex],
                  currentStepIndex: state.tutorialStepIndex,
                  totalSteps: _cubit.tutorialSteps.length,
                  onSkip: _cubit.completeTutorial,
                  onNext: _cubit.handleTutorialNext,
                  onTargetTap: _cubit.handleTutorialTargetTap,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildInitialUI() {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Padding(
        padding: 12.paddingAll,
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.50,
              height: size.width * 0.50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _theme.colorScheme.primary.withValues(alpha: 0.22),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: 70.borderRadius,
                    child: AppAssetImage(
                      path: AppAssets.icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppFilledButton(
                      key: _cubit.scanButtonKey,
                      onPressed: _cubit.onScanButtonTap,
                      icon: Icons.auto_awesome,
                      text: _l10n.onboardingStartScan,
                    ),
                  ),
                  12.height,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppFilledButton(
                      key: _cubit.galleryButtonKey,
                      onPressed: () =>
                          _cubit.navigator.pushMediaTypeSelection(),
                      icon: Icons.photo_library_outlined,
                      backgroundColor: _theme.colorScheme.primary.withValues(
                        alpha: 0.08,
                      ),
                      foregroundColor: _theme.colorScheme.primary,
                      text: _l10n.galleryManager,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(ScanState state) {
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

    final double size = MediaQuery.sizeOf(context).width * 0.3;
    final double progressSize = size + 24;

    return Center(
      child: SizedBox(
        width: progressSize,
        height: progressSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Continuous rotating ring
            RotationTransition(
              turns: _rotationController,
              child: SizedBox(
                width: progressSize,
                height: progressSize,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _theme.colorScheme.primary,
                  ),
                ),
              ),
            ),

            // Central mascot container
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _theme.colorScheme.surface,
                    _theme.colorScheme.surfaceBright,
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.glassStroke, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.16),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(iconData, size: 80, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ScanState state) {
    if (state.status.isLoading) {
      return Center(
        child: Padding(
          padding: 32.paddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLoading(state),
              40.height,
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
          style: _theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Container(
        margin: 24.paddingHorizontal,
        padding: 24.paddingAll,
        decoration: BoxDecoration(
          borderRadius: 28.borderRadius,
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: AppColors.glassStroke),
        ),
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
              style: _theme.textTheme.bodyMedium?.copyWith(
                color: _theme.colorScheme.onSecondary,
              ),
            ),
            24.height,
            ElevatedButton(
              onPressed: () => _cubit.reset(),
              child: Text(_l10n.back),
            ),
          ],
        ),
      ),
    );
  }
}
