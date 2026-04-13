import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';

class GalleryManagerState extends Equatable {
  final LoadStatus status;
  final List<AssetEntity> assets;
  final String? errorMessage;
  final Set<String> selectedPhotoIds;

  const GalleryManagerState({
    this.assets = const [],
    this.status = LoadStatus.initial,
    this.errorMessage,
    this.selectedPhotoIds = const {},
  });

  GalleryManagerState copyWith({
    List<AssetEntity>? assets,
    LoadStatus? status,
    String? errorMessage,
    Set<String>? selectedPhotoIds,
  }) {
    return GalleryManagerState(
      assets: assets ?? this.assets,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
    );
  }

  @override
  List<Object?> get props => [assets, status, errorMessage, selectedPhotoIds];
}
