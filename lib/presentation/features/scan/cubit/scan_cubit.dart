import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/constants/key_constants.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/services/permission_service.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/scan/navigator/scan_navigator.dart';
import 'package:twinfix/presentation/features/scan/widgets/scan_tutorial_overlay.dart';
import 'package:twinfix/presentation/features/scan_result/pages/scan_result_page.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/scan_mode.dart';

import '../../../../domain/entities/photo_item.dart';
import '../../../../domain/usecases/get_photos_usecase.dart';
import '../../../../core/repositories/user_repository.dart';

part 'scan_state.dart';

class ScanCubit extends BaseCubit<ScanState> {
  final GetPhotosUseCase getPhotosUseCase;
  final UserRepository userRepository;
  final AppCubit globalAppCubit;
  final ScanNavigator navigator;
  final SharedPreferences sharedPreferences;
  final PermissionService permissionService;

  ScanCubit({
    required this.getPhotosUseCase,
    required this.userRepository,
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

  Future<void> startScan() async {
    final mode = state.currentMode;
    safeEmit(
      state.copyWith(
        status: LoadStatus.loading,
        progress: 0.0,
        currentMode: mode,
      ),
    );

    final startTime = DateTime.now();

    try {
      // 1. Chạy tiến trình quét thực tế
      final scanTask = _performActualScan(mode: mode);

      List<PhotoItem>? duplicates;
      bool isScanDone = false;

      scanTask.then((value) {
        duplicates = value;
        isScanDone = true;
      });

      // 2. Vòng lặp cập nhật tiến trình (Progress Loop)
      while (!isScanDone ||
          DateTime.now().difference(startTime).inMilliseconds < 3000) {
        await Future.delayed(100.milliseconds);

        final elapsedMs = DateTime.now().difference(startTime).inMilliseconds;
        double newProgress;

        if (elapsedMs < 3000) {
          // Giai đoạn 1: Chạy đều từ 0% -> 90% trong 3 giây đầu
          newProgress = (elapsedMs / 3000) * 0.9;
        } else {
          // Giai đoạn 2: Quét lâu hơn 3 giây -> Chạy cực chậm từ 90% -> 99%
          // Mỗi 100ms tăng thêm 0.1% để người dùng thấy "vẫn đang chạy"
          final extendedMs = elapsedMs - 3000;
          newProgress = 0.9 + (extendedMs / 10000) * 0.09;
          if (newProgress > 0.99) newProgress = 0.99;
        }

        if (state.status.isLoading) {
          safeEmit(state.copyWith(progress: newProgress));
        } else {
          break; // Nếu bị lỗi hoặc dừng đột ngột
        }
      }

      // 3. Hoàn tất
      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          duplicates: duplicates ?? [],
          progress: 1.0,
        ),
      );

      // Chờ một chút để người dùng thấy 100% trước khi chuyển trang
      await Future.delayed(300.milliseconds);

      navigator.toScanResult(
        args: ScanResultPageArgs(initialDuplicates: duplicates ?? []),
      );
      reset();
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> onScanButtonTap() async {
    final hasPerm = await permissionService.requestPhotoPermission();
    if (hasPerm) {
      startScan();
    } else {
      //TODO: Logic handle permission denied
    }
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

  Future<List<PhotoItem>> _performActualScan({required ScanMode mode}) async {
    await getPhotosUseCase.executeScanInfo(isPro: mode.isDeep);
    final items = await getPhotosUseCase.executeGetGroupedList();
    return items.where((element) => !element.type.isNormal).toList();
  }

  void switchMode({required ScanMode mode}) {
    safeEmit(state.copyWith(currentMode: mode));
  }

  void reset() {
    safeEmit(ScanState.initial());
  }

  void toScanResult() {
    navigator.toScanResult(
      args: ScanResultPageArgs(initialDuplicates: state.duplicates),
    );
  }
}
