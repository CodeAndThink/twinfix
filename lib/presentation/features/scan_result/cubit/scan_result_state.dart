import 'package:equatable/equatable.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../domain/entities/photo_item.dart';

class ScanResultState extends Equatable {
  final LoadStatus status;
  final List<PhotoItem> duplicates;
  final Map<String, List<PhotoItem>> groupedResults;
  final Set<String> selectedPhotoIds;
  final String? errorMessage;

  const ScanResultState({
    required this.status,
    this.duplicates = const [],
    this.groupedResults = const {},
    this.selectedPhotoIds = const {},
    this.errorMessage,
  });

  factory ScanResultState.initial() =>
      const ScanResultState(status: LoadStatus.initial);

  ScanResultState copyWith({
    LoadStatus? status,
    List<PhotoItem>? duplicates,
    Map<String, List<PhotoItem>>? groupedResults,
    Set<String>? selectedPhotoIds,
    String? errorMessage,
  }) {
    return ScanResultState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      groupedResults: groupedResults ?? this.groupedResults,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    duplicates,
    groupedResults,
    selectedPhotoIds,
    errorMessage,
  ];
}
