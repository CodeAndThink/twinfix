import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class DocumentDetectionState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> documents;
  final List<String> selectedIds;
  final int scanProgress;
  final int scanTotal;
  final String? errorMessage;

  const DocumentDetectionState({
    this.status = LoadStatus.initial,
    this.documents = const [],
    this.selectedIds = const [],
    this.scanProgress = 0,
    this.scanTotal = 0,
    this.errorMessage,
  });

  DocumentDetectionState copyWith({
    LoadStatus? status,
    List<MediaItem>? documents,
    List<String>? selectedIds,
    int? scanProgress,
    int? scanTotal,
    String? errorMessage,
  }) {
    return DocumentDetectionState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      selectedIds: selectedIds ?? this.selectedIds,
      scanProgress: scanProgress ?? this.scanProgress,
      scanTotal: scanTotal ?? this.scanTotal,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    documents,
    selectedIds,
    scanProgress,
    scanTotal,
    errorMessage,
  ];
}
