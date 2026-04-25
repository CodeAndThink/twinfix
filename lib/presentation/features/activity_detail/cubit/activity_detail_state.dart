import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';

class ActivityDetailState extends Equatable {
  final LoadStatus status;
  final List<DeletionHistory> history;
  final String? errorMessage;

  const ActivityDetailState({
    required this.status,
    this.history = const [],
    this.errorMessage,
  });

  factory ActivityDetailState.initial() =>
      const ActivityDetailState(status: LoadStatus.initial);

  ActivityDetailState copyWith({
    LoadStatus? status,
    List<DeletionHistory>? history,
    String? errorMessage,
  }) {
    return ActivityDetailState(
      status: status ?? this.status,
      history: history ?? this.history,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, history, errorMessage];
}
