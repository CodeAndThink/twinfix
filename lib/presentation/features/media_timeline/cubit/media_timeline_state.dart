import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/core/enums/sort_type.dart';

enum TimelineMode { day, month, year }

class MediaTimelineState extends Equatable {
  final LoadStatus status;
  final TimelineMode mode;
  final Map<String, List<MediaItem>> groupedItems;
  final String? errorMessage;
  final SortType sortType;

  const MediaTimelineState({
    required this.status,
    required this.mode,
    required this.groupedItems,
    this.errorMessage,
    this.sortType = SortType.dateDesc,
  });

  factory MediaTimelineState.initial() {
    return const MediaTimelineState(
      status: LoadStatus.initial,
      mode: TimelineMode.day,
      groupedItems: {},
      sortType: SortType.dateDesc,
    );
  }

  MediaTimelineState copyWith({
    LoadStatus? status,
    TimelineMode? mode,
    Map<String, List<MediaItem>>? groupedItems,
    String? errorMessage,
    SortType? sortType,
  }) {
    return MediaTimelineState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      groupedItems: groupedItems ?? this.groupedItems,
      errorMessage: errorMessage,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    mode,
    groupedItems,
    errorMessage,
    sortType,
  ];
}
