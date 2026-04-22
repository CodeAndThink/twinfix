import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class RemoveGPSState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> photos;
  final List<String> selectedIds;
  final String? errorMessage;

  const RemoveGPSState({
    this.status = LoadStatus.initial,
    this.photos = const [],
    this.selectedIds = const [],
    this.errorMessage,
  });

  RemoveGPSState copyWith({
    LoadStatus? status,
    List<MediaItem>? photos,
    List<String>? selectedIds,
    String? errorMessage,
  }) {
    return RemoveGPSState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      selectedIds: selectedIds ?? this.selectedIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, photos, selectedIds, errorMessage];
}
