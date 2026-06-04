import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import '../../../../core/di/injection.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/extensions.dart';
import '../navigator/scan_navigator.dart';
import '../widgets/scan_tutorial_overlay.dart';
import '../../../../core/services/permission_service.dart';

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
    _rotationController = AnimationController(vsync: this, duration: 3.seconds)
      ..repeat();
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
    return SafeArea(
      child: BlocBuilder<ScanCubit, ScanState>(
        buildWhen: (previous, current) =>
            previous.isTutorialVisible != current.isTutorialVisible ||
            previous.tutorialStepIndex != current.tutorialStepIndex ||
            previous.tutorialTargetRect != current.tutorialTargetRect,
        builder: (context, state) {
          if (state.isTutorialVisible) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _cubit.updateTutorialTargetRect();
            });
          }

          return Stack(
            key: _cubit.tutorialStackKey,
            children: [
              Positioned.fill(child: _buildInitialUI()),
              if (state.isTutorialVisible && state.tutorialTargetRect != null)
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
      ),
    );
  }

  Widget _buildInitialUI() {
    return SafeArea(
      child: Padding(
        padding: 12.paddingAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: AppFilledButton(
                key: _cubit.scanButtonKey,
                onPressed: () async {
                  final hasPerm = await locator<PermissionService>()
                      .requestPhotoPermission(context);
                  if (hasPerm && context.mounted) {
                    _cubit.onScanButtonTap();
                  }
                },
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
                onPressed: () async {
                  final hasPerm = await locator<PermissionService>()
                      .requestPhotoPermission(context);
                  if (hasPerm && context.mounted) {
                    _cubit.onGalleryButtonTap();
                  }
                },
                icon: Icons.photo_library_outlined,
                backgroundColor: _theme.colorScheme.primary.withValues(
                  alpha: 0.08,
                ),
                foregroundColor: _theme.colorScheme.primary,
                text: _l10n.galleryManager,
              ),
            ),
            12.height,
            SizedBox(
              width: double.infinity,
              height: 48,
              child: AppFilledButton(
                key: _cubit.mediaTimelineButtonKey,
                onPressed: () async {
                  final hasPerm = await locator<PermissionService>()
                      .requestPhotoPermission(context);
                  if (hasPerm && context.mounted) {
                    _cubit.onMediaTimelineButtonTap();
                  }
                },
                icon: Icons.timeline,
                backgroundColor: _theme.colorScheme.primary.withValues(
                  alpha: 0.08,
                ),
                foregroundColor: _theme.colorScheme.primary,
                text: _l10n.mediaTimeline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
