import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/result_view_mode.dart';
import 'package:twinfix/domain/entities/photo_item.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../../../../core/repositories/user_repository.dart';
import '../navigator/scan_result_navigator.dart';
import 'scan_result_state.dart';

class ScanResultCubit extends BaseCubit<ScanResultState> {
  final UserRepository userRepository;
  final ScanResultNavigator navigator;

  ScanResultCubit({required this.userRepository, required this.navigator})
    : super(ScanResultState.initial());

  void init(List<PhotoItem> items) {
    if (items.isEmpty) {
      safeEmit(state.copyWith(status: LoadStatus.success, duplicates: []));
      return;
    }

    final Map<String, List<PhotoItem>> groups = {};
    for (var item in items) {
      final key = item.checksum ?? item.createDate.toString().split(' ')[0];
      groups.putIfAbsent(key, () => []).add(item);
    }

    safeEmit(
      state.copyWith(
        status: LoadStatus.success,
        duplicates: items,
        groupedResults: groups,
      ),
    );
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
