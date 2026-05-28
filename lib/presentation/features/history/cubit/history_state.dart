import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';

class HistoryState extends Equatable {
  final LoadStatus status;
  final List<DeletionHistory> history;
  final bool hasMore;
  final String? errorMessage;

  const HistoryState({
    required this.status,
    this.history = const [],
    this.hasMore = true,
    this.errorMessage,
  });

  factory HistoryState.initial() =>
      const HistoryState(status: LoadStatus.initial);

  HistoryState copyWith({
    LoadStatus? status,
    List<DeletionHistory>? history,
    bool? hasMore,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      history: history ?? this.history,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, history, hasMore, errorMessage];
}
