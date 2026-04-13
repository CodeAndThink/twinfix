import 'package:equatable/equatable.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/enums/result_view_mode.dart';
import '../../../../domain/entities/photo_item.dart';

class ScanResultState extends Equatable {
  final LoadStatus status;
  final List<PhotoItem> duplicates;
  final Map<String, List<PhotoItem>> groupedResults;
  final Set<String> selectedPhotoIds;
  final ResultViewMode viewMode;
  final String? errorMessage;

  const ScanResultState({
    required this.status,
    this.duplicates = const [],
    this.groupedResults = const {},
    this.selectedPhotoIds = const {},
    this.viewMode = ResultViewMode.individual,
    this.errorMessage,
  });

  factory ScanResultState.initial() =>
      const ScanResultState(status: LoadStatus.initial);

  ScanResultState copyWith({
    LoadStatus? status,
    List<PhotoItem>? duplicates,
    Map<String, List<PhotoItem>>? groupedResults,
    Set<String>? selectedPhotoIds,
    ResultViewMode? viewMode,
    String? errorMessage,
  }) {
    return ScanResultState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      groupedResults: groupedResults ?? this.groupedResults,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
      viewMode: viewMode ?? this.viewMode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    duplicates,
    groupedResults,
    selectedPhotoIds,
    viewMode,
    errorMessage,
  ];
}
