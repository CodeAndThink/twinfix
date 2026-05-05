import 'dart:async';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/usecases/get_photos_usecase.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../navigator/scan_loading_navigator.dart';
import 'scan_loading_state.dart';

class ScanLoadingCubit extends BaseCubit<ScanLoadingState> {
  final GetPhotosUseCase getPhotosUseCase;
  final ScanLoadingNavigator navigator;

  ScanLoadingCubit({
    required this.getPhotosUseCase,
    required this.navigator,
    ScanMode? initialMode,
  }) : super(ScanLoadingState.initial(mode: initialMode));

  Future<void> startScan() async {
    final mode = state.currentMode;
    safeEmit(state.copyWith(status: LoadStatus.loading));

    try {
      // 1. Khởi động việc quét thực tế và bộ đếm thời gian tối thiểu 3 giây song song
      final results = await Future.wait([
        _performActualScan(mode: mode),
        Future.delayed(const Duration(seconds: 3)),
      ]);

      final duplicates = results[0] as List<MediaItem>;

      // 2. Chờ xong cả hai mới cập nhật trạng thái thành công
      safeEmit(
        state.copyWith(duplicates: duplicates, status: LoadStatus.success),
      );
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
