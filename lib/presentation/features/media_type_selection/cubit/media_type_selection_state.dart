import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class MediaTypeSelectionState extends Equatable {
  final LoadStatus status;

  const MediaTypeSelectionState({required this.status});

  factory MediaTypeSelectionState.initial() =>
      const MediaTypeSelectionState(status: LoadStatus.initial);

  MediaTypeSelectionState copyWith({LoadStatus? status}) {
    return MediaTypeSelectionState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
