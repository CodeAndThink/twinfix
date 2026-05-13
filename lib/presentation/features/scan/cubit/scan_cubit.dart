import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/constants/key_constants.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/services/permission_service.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/scan/navigator/scan_navigator.dart';
import 'package:twinfix/presentation/features/scan/widgets/scan_tutorial_overlay.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import '../../../../domain/usecases/get_photos_usecase.dart';

part 'scan_state.dart';

class ScanCubit extends BaseCubit<ScanState> {
  final GetPhotosUseCase getPhotosUseCase;
  final AppCubit globalAppCubit;
  final ScanNavigator navigator;
  final SharedPreferences sharedPreferences;
  final PermissionService permissionService;

  ScanCubit({
    required this.getPhotosUseCase,
    required this.globalAppCubit,
    required this.navigator,
    required this.sharedPreferences,
    required this.permissionService,
  }) : super(ScanState.initial());

  final GlobalKey tutorialStackKey = GlobalKey();
  final GlobalKey scanButtonKey = GlobalKey();
  final GlobalKey galleryButtonKey = GlobalKey();

  List<ScanTutorialStep> get tutorialSteps => [
    ScanTutorialStep(
      title: S.current.startQuickScan,
      message: S.current.startQuickScanDescription,
      nextLabel: S.current.next,
    ),
    ScanTutorialStep(
      title: S.current.openGalleryManager,
      message: S.current.openGalleryManagerDescription,
      nextLabel: S.current.done,
    ),
  ];

  //Public Methods

  Future<void> onScanButtonTap() async {
    navigator.toScanLoading();
  }

  Future<void> onGalleryButtonTap() async {
    navigator.pushMediaTypeSelection();
  }

  Future<void> prepareTutorialIfNeeded() async {
    final isCompleted =
        sharedPreferences.getBool(KeyConstants.scanTutorialCompleted) ?? false;
    if (isCompleted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      safeEmit(state.copyWith(isTutorialVisible: true, tutorialStepIndex: 0));
      updateTutorialTargetRect();
    });
  }

  GlobalKey get _currentTutorialTargetKey =>
      state.tutorialStepIndex == 0 ? scanButtonKey : galleryButtonKey;

  void goToTutorialStep(int index) {
    safeEmit(
      state.copyWith(tutorialTargetRect: null, tutorialStepIndex: index),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => updateTutorialTargetRect(),
    );
  }

  void handleTutorialTargetTap() {
    if (state.tutorialStepIndex == 0) {
      handleTutorialNext();
      return;
    }
    completeTutorial(openGalleryManager: true);
  }

  void updateTutorialTargetRect() {
    if (!state.isTutorialVisible) return;

    final stackContext = tutorialStackKey.currentContext;
    final targetContext = _currentTutorialTargetKey.currentContext;
    if (stackContext == null || targetContext == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => updateTutorialTargetRect(),
      );
      return;
    }

    final stackBox = stackContext.findRenderObject() as RenderBox?;
    final targetBox = targetContext.findRenderObject() as RenderBox?;
    if (stackBox == null || targetBox == null || !targetBox.hasSize) return;

    final offset = targetBox.localToGlobal(Offset.zero, ancestor: stackBox);
    final nextRect = offset & targetBox.size;

    if (state.tutorialTargetRect == nextRect) return;

    safeEmit(state.copyWith(tutorialTargetRect: nextRect));
  }

  Future<void> completeTutorial({bool openGalleryManager = false}) async {
    final prefs = locator<SharedPreferences>();
    await prefs.setBool(KeyConstants.scanTutorialCompleted, true);

    safeEmit(state.copyWith(isTutorialVisible: false));

    if (openGalleryManager) {
      navigator.pushMediaTypeSelection();
    }
  }

  void handleTutorialNext() {
    if (state.tutorialStepIndex >= tutorialSteps.length - 1) {
      completeTutorial();
      return;
    }
    goToTutorialStep(state.tutorialStepIndex + 1);
  }

  // Privated Methods

  void switchMode({required ScanMode mode}) {
    safeEmit(state.copyWith(currentMode: mode));
  }

  void reset() {
    safeEmit(ScanState.initial());
  }
}
