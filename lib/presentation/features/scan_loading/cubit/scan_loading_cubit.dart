import 'dart:async';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/usecases/get_photos_usecase.dart';
import 'package:twinfix/presentation/features/scan_result/pages/scan_result_page.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../navigator/scan_loading_navigator.dart';
import 'scan_loading_state.dart';

class ScanLoadingCubit extends BaseCubit<ScanLoadingState> {
  final GetPhotosUseCase getPhotosUseCase;
  final ScanLoadingNavigator navigator;

  ScanLoadingCubit({required this.getPhotosUseCase, required this.navigator})
    : super(ScanLoadingState());

  Future<void> startScan() async {
    final mode = state.currentMode;
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: LoadStatus.loading));

    try {
      final duplicates = await _performActualScan(mode: mode);

      safeEmit(
        state.copyWith(duplicates: duplicates, status: LoadStatus.success),
      );
      if (state.duplicates.isNotEmpty) {
        navigator.replaceWithScanResult(
          ScanResultPageArgs(initialDuplicates: state.duplicates),
        );
      }
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<List<MediaItem>> _performActualScan({required ScanMode mode}) async {
    await getPhotosUseCase.executeScanInfo(
      isPro: mode.isDeep,
      onProgress: (current, total) {
        safeEmit(state.copyWith(scanProgress: current, scanTotal: total));
      },
    );
    final items = await getPhotosUseCase.executeGetGroupedList();
    return items.where((element) => !element.type.isNormal).toList();
  }
}
