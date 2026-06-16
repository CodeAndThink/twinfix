import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/scan_foreground_service.dart';
import 'package:twinfix/domain/enums/scan_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/blur_detection/cubit/blur_detection_state.dart';
import 'package:twinfix/presentation/features/blur_detection/navigator/blur_detection_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class BlurDetectionCubit extends BaseCubit<BlurDetectionState> {
  final BlurDetectionNavigator navigator;
  final PhotoRepository photoRepository;

  BlurDetectionCubit({required this.navigator, required this.photoRepository})
    : super(const BlurDetectionState());

  Future<void> scan() async {
    emit(state.copyWith(status: LoadStatus.loading));

    await ScanForegroundService.instance.start(
      title: S.current.notifScanningTitle,
      body: S.current.blurryPhotos,
    );

    try {
      final blurryAssets = await photoRepository.getBlurryPhotos(
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

      final count = blurryAssets.length;
      await ScanForegroundService.instance.stop(
        resultCount: count,
        completionTitle: S.current.notifScanCompleteTitle,
        completionBody: count > 0
            ? S.current.notifScanCompleteBlurry(count)
            : S.current.notifScanCompleteNone,
        scanType: ScanType.blurry,
      );

      emit(
        state.copyWith(status: LoadStatus.success, blurryAssets: blurryAssets),
      );
    } catch (e) {
      await ScanForegroundService.instance.cancel();
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void onShowResults() {
    navigator.pushGalleryManagerResults(state.blurryAssets);
  }

  @override
  Future<void> close() {
    photoRepository.cancelScan();
    ScanForegroundService.instance.cancel();
    return super.close();
  }
}
