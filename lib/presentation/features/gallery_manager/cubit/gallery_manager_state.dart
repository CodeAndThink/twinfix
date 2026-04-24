import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class GalleryManagerState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> assets;
  final String? errorMessage;
  final Set<String> selectedPhotoIds;
  final SortType sortType;
  final Map<String, int> assetSizes;

  const GalleryManagerState({
    this.assets = const [],
    this.status = LoadStatus.initial,
    this.errorMessage,
    this.selectedPhotoIds = const {},
    this.sortType = SortType.dateDesc,
    this.assetSizes = const {},
  });

  GalleryManagerState copyWith({
    List<MediaItem>? assets,
    LoadStatus? status,
    String? errorMessage,
    Set<String>? selectedPhotoIds,
    SortType? sortType,
    Map<String, int>? assetSizes,
  }) {
    return GalleryManagerState(
      assets: assets ?? this.assets,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
      sortType: sortType ?? this.sortType,
      assetSizes: assetSizes ?? this.assetSizes,
    );
  }

  @override
  List<Object?> get props => [
        assets,
        status,
        errorMessage,
        selectedPhotoIds,
        sortType,
        assetSizes,
      ];
}
