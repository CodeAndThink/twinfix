import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/utils/datetime_utils.dart';
import 'package:twinfix/core/enums/sort_type.dart';

import 'media_timeline_state.dart';
import '../navigator/media_timeline_navigator.dart';

class MediaTimelineCubit extends BaseCubit<MediaTimelineState> {
  final PhotoRepository photoRepository;
  final MediaTimelineNavigator navigator;

  List<MediaItem> _allAssets = [];

  MediaTimelineCubit({required this.photoRepository, required this.navigator})
    : super(MediaTimelineState.initial());

  Future<void> init() async {
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      _allAssets = await photoRepository.getGalleryAssets(
        type: RequestType.image,
      );
      _groupAssets();
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void changeMode(TimelineMode mode) {
    if (mode == state.mode) return;
    _groupAssets(newMode: mode);
  }

  void changeSortType({required SortType sortType}) {
    if (state.sortType == sortType) return;
    _groupAssets(newSortType: sortType);
  }

  void _groupAssets({TimelineMode? newMode, SortType? newSortType}) {
    final mode = newMode ?? state.mode;
    final sortType = newSortType ?? state.sortType;
    final Map<String, List<MediaItem>> tempGrouped = {};

    for (var asset in _allAssets) {
      String key = DatetimeUtils.formatTimelineDate(asset.createDateTime, mode);
      if (!tempGrouped.containsKey(key)) {
        tempGrouped[key] = [];
      }
      tempGrouped[key]!.add(asset);
    }

    // Now sort the groups
    final entries = tempGrouped.entries.toList();
    entries.sort((a, b) {
      switch (sortType) {
        case SortType.dateAsc:
          final dateA = a.value.first.createDateTime;
          final dateB = b.value.first.createDateTime;
          return dateA.compareTo(dateB);
        case SortType.dateDesc:
          final dateA = a.value.first.createDateTime;
          final dateB = b.value.first.createDateTime;
          return dateB.compareTo(dateA);
        case SortType.countAsc:
          int compare = a.value.length.compareTo(b.value.length);
          if (compare == 0) {
            return b.value.first.createDateTime.compareTo(
              a.value.first.createDateTime,
            );
          }
          return compare;
        case SortType.countDesc:
          int compare = b.value.length.compareTo(a.value.length);
          if (compare == 0) {
            return b.value.first.createDateTime.compareTo(
              a.value.first.createDateTime,
            );
          }
          return compare;

        default:
          return 0;
      }
    });

    final Map<String, List<MediaItem>> finalGrouped = {};
    for (var entry in entries) {
      // Sort items inside the group
      entry.value.sort((a, b) {
        if (sortType == SortType.dateAsc) {
          return a.createDateTime.compareTo(b.createDateTime);
        } else {
          return b.createDateTime.compareTo(a.createDateTime);
        }
      });
      finalGrouped[entry.key] = entry.value;
    }

    safeEmit(
      state.copyWith(
        mode: mode,
        sortType: sortType,
        status: LoadStatus.success,
        groupedItems: finalGrouped,
      ),
    );
  }

  void onGroupTap(List<MediaItem> items) {
    navigator.navigateToGalleryManager(items);
  }
}
