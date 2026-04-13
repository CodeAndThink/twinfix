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
