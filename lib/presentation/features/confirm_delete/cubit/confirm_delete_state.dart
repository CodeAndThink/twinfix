import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ConfirmDeleteState extends Equatable {
  final LoadStatus status;
  final List<dynamic> itemsToDelete;
  final String? errorMessage;

  const ConfirmDeleteState({
    required this.status,
    required this.itemsToDelete,
    this.errorMessage,
  });

  factory ConfirmDeleteState.initial() {
    return const ConfirmDeleteState(
      status: LoadStatus.initial,
      itemsToDelete: [],
    );
  }

  ConfirmDeleteState copyWith({
    LoadStatus? status,
    List<dynamic>? itemsToDelete,
    String? errorMessage,
  }) {
    return ConfirmDeleteState(
      status: status ?? this.status,
      itemsToDelete: itemsToDelete ?? this.itemsToDelete,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, itemsToDelete, errorMessage];
}
