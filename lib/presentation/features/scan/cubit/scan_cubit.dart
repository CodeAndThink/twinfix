import 'package:equatable/equatable.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/scan/navigator/scan_navigator.dart';
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

  ScanCubit({
    required this.getPhotosUseCase,
    required this.userRepository,
    required this.globalAppCubit,
    required this.navigator,
  }) : super(ScanState.initial());

  Future<void> startScan() async {
    final mode = state.currentMode;
    safeEmit(
      state.copyWith(
        status: LoadStatus.loading,
        progress: 0.05,
        currentMode: mode,
      ),
    );

    try {
      final results = await Future.wait([
        _performActualScan(mode: mode),
        _simulateProgress(seconds: 3),
      ]);

      final duplicates = results[0] as List<PhotoItem>;

      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          duplicates: duplicates,
          progress: 1.0,
        ),
      );
      navigator.toScanResult(
        args: ScanResultPageArgs(initialDuplicates: duplicates),
      );
      reset();
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    } finally {
      if (!state.status.isInitial) {
        safeEmit(state.copyWith(progress: 1.0));
      }
    }
  }

  Future<List<PhotoItem>> _performActualScan({required ScanMode mode}) async {
    await getPhotosUseCase.executeScanInfo(isPro: mode.isDeep);
    final items = await getPhotosUseCase.executeGetGroupedList();
    return items.where((element) => !element.type.isNormal).toList();
  }

  Future<void> _simulateProgress({required int seconds}) async {
    final steps = seconds * 20;
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(50.milliseconds);
      if (state.status.isLoading) {
        final targetProgress = (i / steps) * 0.95;
        if (targetProgress > state.progress) {
          safeEmit(state.copyWith(progress: targetProgress));
        }
      }
    }
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
