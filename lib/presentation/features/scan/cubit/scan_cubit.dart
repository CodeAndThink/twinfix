import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import 'package:twinfix/core/enums/result_view_mode.dart';
import 'package:twinfix/domain/enums/photo_type.dart';

import '../../../../domain/entities/photo_item.dart';
import '../../../../domain/usecases/get_photos_usecase.dart';
import '../../../../core/repositories/user_repository.dart';

part 'scan_state.dart';

@injectable
class ScanCubit extends BaseCubit<ScanState> {
  final GetPhotosUseCase getPhotosUseCase;
  final UserRepository userRepository;
  final AppCubit globalAppCubit;

  ScanCubit({
    required this.getPhotosUseCase,
    required this.userRepository,
    required this.globalAppCubit,
  }) : super(ScanState.initial());

  Future<void> startScan() async {
    final mode = state.currentMode;
    safeEmit(
      state.copyWith(
        status: LoadStatus.loading,
        progress: 0.05,
        currentMode: mode,
        selectedPhotoIds: {},
      ),
    );

    try {
      // Chạy song song: Quét thực tế và Giả lập tiến trình tối thiểu 3 giây
      final results = await Future.wait([
        _performActualScan(mode),
        _simulateProgress(3),
      ]);

      final duplicates = results[0] as List<PhotoItem>;

      // Logic Grouping cho Grid View
      final Map<String, List<PhotoItem>> groups = {};
      for (var item in duplicates) {
        final key = item.checksum ?? item.createDate.toString().split(' ')[0];
        groups.putIfAbsent(key, () => []).add(item);
      }

      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          duplicates: duplicates,
          groupedResults: groups,
          progress: 1.0,
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<List<PhotoItem>> _performActualScan(ScanMode mode) async {
    // Bắt đầu gọi Isolate thực thi quét ảnh trùng lặp
    await getPhotosUseCase.executeScanInfo(isPro: mode.isDeep);
    // Lấy danh sách kết quả sau khi thuật toán xong
    final items = await getPhotosUseCase.executeGetGroupedList();
    // Chỉ lấy ảnh có mark là duplicate/burst/blurry/screenshot
    return items.where((element) => element.type != PhotoType.normal).toList();
  }

  Future<void> _simulateProgress(int seconds) async {
    final steps = seconds * 20; // 50ms mỗi bước để mượt hơn
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      // Chỉ cập nhật progress đến tối đa 95% trong khi chờ quét thật
      if (state.status.isLoading) {
        final targetProgress = (i / steps) * 0.95;
        if (targetProgress > state.progress) {
          safeEmit(state.copyWith(progress: targetProgress));
        }
      }
    }
  }

  void switchMode(ScanMode mode) {
    safeEmit(state.copyWith(currentMode: mode));
  }

  void switchViewMode(ResultViewMode mode) {
    safeEmit(state.copyWith(viewMode: mode));
  }

  void togglePhotoSelection(String id) {
    final currentSelected = Set<String>.from(state.selectedPhotoIds);
    if (currentSelected.contains(id)) {
      currentSelected.remove(id);
    } else {
      currentSelected.add(id);
    }
    safeEmit(state.copyWith(selectedPhotoIds: currentSelected));
  }

  void toggleGroupSelection(String groupKey, bool selectAll) {
    final currentSelected = Set<String>.from(state.selectedPhotoIds);
    final groupItems = state.groupedResults[groupKey] ?? [];

    for (var item in groupItems) {
      if (selectAll) {
        currentSelected.add(item.id);
      } else {
        currentSelected.remove(item.id);
      }
    }
    safeEmit(state.copyWith(selectedPhotoIds: currentSelected));
  }

  void removePhotoFromList(int index, {bool isDiscard = false}) {
    // Trong chế độ Stack/Swiper: vuốt lời/phải chỉ đánh dấu xóa hoặc giữ
    // Nếu isDiscard = true (vuốt trái), thêm vào danh sách selected để xóa sau
    if (state.status.isSuccess) {
      if (isDiscard) {
        final photo = state.duplicates[index];
        togglePhotoSelection(photo.id);
      }
    }
  }

  Future<void> confirmDeletion() async {
    if (state.selectedPhotoIds.isEmpty) return;

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final idsToDelete = state.selectedPhotoIds.toList();
      final result = await PhotoManager.editor.deleteWithIds(idsToDelete);

      if (result.isNotEmpty) {
        // Tính toán tổng dung lượng đã xóa
        int totalSaved = 0;
        final remainingDuplicates = List<PhotoItem>.from(state.duplicates);

        remainingDuplicates.removeWhere((item) {
          if (state.selectedPhotoIds.contains(item.id)) {
            totalSaved += item.sizeBytes;
            return true;
          }
          return false;
        });

        await userRepository.addCleanedBytes(totalSaved);

        // Group lại danh sách mới
        final Map<String, List<PhotoItem>> newGroups = {};
        for (var item in remainingDuplicates) {
          final key = item.checksum ?? item.createDate.toString().split(' ')[0];
          newGroups.putIfAbsent(key, () => []).add(item);
        }

        safeEmit(
          state.copyWith(
            status: LoadStatus.success,
            duplicates: remainingDuplicates,
            groupedResults: newGroups,
            selectedPhotoIds: {},
          ),
        );
      } else {
        safeEmit(state.copyWith(status: LoadStatus.success));
      }
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedPhotoIds: {}));
  }
}
