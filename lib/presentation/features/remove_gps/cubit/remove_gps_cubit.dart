import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/scan_foreground_service.dart';
import 'package:twinfix/domain/enums/scan_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'remove_gps_state.dart';
import '../navigator/remove_gps_navigator.dart';

class RemoveGPSCubit extends BaseCubit<RemoveGPSState> {
  final PhotoRepository _photoRepository;
  final RemoveGPSNavigator navigator;

  RemoveGPSCubit(this._photoRepository, this.navigator)
    : super(const RemoveGPSState());

  Future<void> startScan() async {
    if (state.status.isLoading) return;
    safeEmit(
      state.copyWith(status: LoadStatus.loading, scanProgress: 0, scanTotal: 0),
    );

    await ScanForegroundService.instance.start(
      title: S.current.notifScanningTitle,
      body: S.current.removeGPS,
    );

    try {
      final photos = await _photoRepository.getPhotosWithGPS(
        onProgress: (current, total) {
          safeEmit(state.copyWith(scanProgress: current, scanTotal: total));
          ScanForegroundService.instance.updateProgress(
            title: S.current.notifScanningTitle,
            body: S.current.notifScanningBody(current, total),
            current: current,
            total: total,
          );
        },
      );

      final count = photos.length;
      await ScanForegroundService.instance.stop(
        resultCount: count,
        completionTitle: S.current.notifScanCompleteTitle,
        completionBody: count > 0
            ? S.current.notifScanCompleteGPS(count)
            : S.current.notifScanCompleteNone,
        scanType: ScanType.gps,
      );

      safeEmit(state.copyWith(status: LoadStatus.success, photos: photos));
    } catch (e) {
      await ScanForegroundService.instance.cancel();
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> onRemoveGPSPressed() async {
    if (state.selectedIds.isEmpty || state.status.isLoading) return;
    safeEmit(state.copyWith(status: LoadStatus.loading));

    final result = await navigator.showSaveOptions(
      initialSaveAsCopy: state.saveAsCopy,
      onOptionSelected: (value) {
        safeEmit(state.copyWith(saveAsCopy: value));
      },
    );

    if (result == true) {
      try {
        await removeGPS();
        navigator.flushBar.showSuccess(message: S.current.gpsRemovedSuccess);
      } catch (e) {
        safeEmit(
          state.copyWith(
            status: LoadStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  void toggleSelection({required String id}) {
    final selectedIds = List<String>.from(state.selectedIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    safeEmit(state.copyWith(selectedIds: selectedIds));
  }

  void selectAll() {
    safeEmit(
      state.copyWith(selectedIds: state.photos.map((e) => e.id).toList()),
    );
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedIds: []));
  }

  void setSaveAsCopy(bool value) {
    safeEmit(state.copyWith(saveAsCopy: value));
  }

  Future<void> removeGPS() async {
    if (state.selectedIds.isEmpty) return;
    if (state.status.isLoading) return;

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      await _photoRepository.removeGPS(
        state.selectedIds,
        replaceOriginal: !state.saveAsCopy,
      );

      // Re-scan to update the list since some photos might have been deleted or added
      await startScan();

      safeEmit(state.copyWith(status: LoadStatus.success, selectedIds: []));

      // Optionally re-scan or just notify user
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  @override
  Future<void> close() {
    _photoRepository.cancelScan();
    ScanForegroundService.instance.cancel();
    return super.close();
  }
}
