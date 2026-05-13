import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class ConfirmDeleteState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> itemsToDelete;
  final String? errorMessage;
  final int totalSizeBytes;

  const ConfirmDeleteState({
    required this.status,
    required this.itemsToDelete,
    this.errorMessage,
    this.totalSizeBytes = 0,
  });

  factory ConfirmDeleteState.initial() {
    return const ConfirmDeleteState(
      status: LoadStatus.initial,
      itemsToDelete: [],
      totalSizeBytes: 0,
    );
  }

  ConfirmDeleteState copyWith({
    LoadStatus? status,
    List<MediaItem>? itemsToDelete,
    String? errorMessage,
    int? totalSizeBytes,
  }) {
    return ConfirmDeleteState(
      status: status ?? this.status,
      itemsToDelete: itemsToDelete ?? this.itemsToDelete,
      errorMessage: errorMessage ?? this.errorMessage,
      totalSizeBytes: totalSizeBytes ?? this.totalSizeBytes,
    );
  }

  @override
  List<Object?> get props => [
    status,
    itemsToDelete,
    errorMessage,
    totalSizeBytes,
  ];
}
