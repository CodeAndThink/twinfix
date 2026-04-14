import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/photo_item.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../navigator/scan_result_navigator.dart';
import 'scan_result_state.dart';

class ScanResultCubit extends BaseCubit<ScanResultState> {
  final ScanResultNavigator navigator;

  ScanResultCubit({required this.navigator}) : super(ScanResultState.initial());

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

  void removeDeletedPhotos({
    required List<String> deletedIds,
    required List<String> unselectedIds,
  }) {
    if (deletedIds.isEmpty && unselectedIds.isEmpty) return;

    final remainingDuplicates = List<PhotoItem>.from(state.duplicates);
    if (deletedIds.isNotEmpty) {
      remainingDuplicates.removeWhere((item) => deletedIds.contains(item.id));
    }

    final Map<String, List<PhotoItem>> newGroups = {};
    for (var item in remainingDuplicates) {
      final key = item.checksum ?? item.createDate.toString().split(' ')[0];
      newGroups.putIfAbsent(key, () => []).add(item);
    }

    final currentSelected = Set<String>.from(state.selectedPhotoIds);
    currentSelected.removeAll(deletedIds);
    currentSelected.removeAll(unselectedIds);

    safeEmit(
      state.copyWith(
        status: LoadStatus.success,
        duplicates: remainingDuplicates,
        groupedResults: newGroups,
        selectedPhotoIds: currentSelected,
      ),
    );
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedPhotoIds: {}));
  }
}
