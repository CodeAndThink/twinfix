import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class RemoveGPSState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> photos;
  final List<String> selectedIds;
  final bool saveAsCopy;
  final String? errorMessage;
  final int scanProgress;
  final int scanTotal;

  const RemoveGPSState({
    this.status = LoadStatus.initial,
    this.photos = const [],
    this.selectedIds = const [],
    this.saveAsCopy = true,
    this.errorMessage,
    this.scanProgress = 0,
    this.scanTotal = 0,
  });

  RemoveGPSState copyWith({
    LoadStatus? status,
    List<MediaItem>? photos,
    List<String>? selectedIds,
    bool? saveAsCopy,
    String? errorMessage,
    int? scanProgress,
    int? scanTotal,
  }) {
    return RemoveGPSState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      selectedIds: selectedIds ?? this.selectedIds,
      saveAsCopy: saveAsCopy ?? this.saveAsCopy,
      errorMessage: errorMessage ?? this.errorMessage,
      scanProgress: scanProgress ?? this.scanProgress,
      scanTotal: scanTotal ?? this.scanTotal,
    );
  }

  @override
  List<Object?> get props => [
    status,
    photos,
    selectedIds,
    saveAsCopy,
    errorMessage,
    scanProgress,
    scanTotal,
  ];
}
