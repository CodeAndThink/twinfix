import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../navigator/scan_result_navigator.dart';
import 'scan_result_state.dart';

class ScanResultCubit extends BaseCubit<ScanResultState> {
  final ScanResultNavigator navigator;

  ScanResultCubit({required this.navigator}) : super(ScanResultState.initial());

  void init(List<MediaItem> items) {
    if (items.isEmpty) {
      safeEmit(state.copyWith(status: LoadStatus.success, duplicates: []));
      return;
    }

    final groups = _groupItems(items);

    safeEmit(
      state.copyWith(
        status: LoadStatus.success,
        duplicates: items,
        groupedResults: groups,
      ),
    );
  }

  /// Groups items by their similarity hash (dHash > pHash > metadata fallback).
  Map<String, List<MediaItem>> _groupItems(List<MediaItem> items) {
    final Map<String, List<MediaItem>> groups = {};
    for (var item in items) {
      final key = _groupKeyFor(item);
      groups.putIfAbsent(key, () => []).add(item);
    }
    return groups;
  }

  /// Returns the pre-calculated group ID, or a fallback if missing.
  String _groupKeyFor(MediaItem item) {
    if (item.groupId != null && item.groupId!.isNotEmpty) return item.groupId!;
    // Fallback if missing for some reason
    if (item.dHash != null && item.dHash!.isNotEmpty) return item.dHash!;
    if (item.pHash != null && item.pHash!.isNotEmpty) return item.pHash!;
    final minuteKey = item.createDateTime.minute.toString().padLeft(2, '0');
    return '${item.width}x${item.height}_$minuteKey';
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

    final remainingDuplicates = List<MediaItem>.from(state.duplicates);
    if (deletedIds.isNotEmpty) {
      remainingDuplicates.removeWhere((item) => deletedIds.contains(item.id));
    }

    final newGroups = _groupItems(remainingDuplicates);

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
