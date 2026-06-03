import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/utils/datetime_utils.dart';

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
    safeEmit(state.copyWith(mode: mode));
    _groupAssets();
  }

  void _groupAssets() {
    final Map<String, List<MediaItem>> grouped = {};

    // Sort all assets descending by date
    _allAssets.sort((a, b) => b.createDateTime.compareTo(a.createDateTime));

    for (var asset in _allAssets) {
      String key = DatetimeUtils.formatTimelineDate(
        asset.createDateTime,
        state.mode,
      );
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(asset);
    }

    safeEmit(state.copyWith(status: LoadStatus.success, groupedItems: grouped));
  }

  void onGroupTap(List<MediaItem> items) {
    navigator.navigateToGalleryManager(items);
  }
}
