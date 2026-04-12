part of 'scan_cubit.dart';

class ScanState extends Equatable {
  final LoadStatus status;
  final List<PhotoItem> duplicates;
  final String? errorMessage;
  final double progress;

  // New fields
  final ScanMode currentMode;
  final ResultViewMode viewMode;
  final Map<String, List<PhotoItem>> groupedResults;
  final Set<String> selectedPhotoIds;

  const ScanState({
    required this.status,
    this.duplicates = const [],
    this.errorMessage,
    this.progress = 0.0,
    this.currentMode = ScanMode.quick,
    this.viewMode = ResultViewMode.individual,
    this.groupedResults = const {},
    this.selectedPhotoIds = const {},
  });

  factory ScanState.initial() => const ScanState(status: LoadStatus.initial);

  ScanState copyWith({
    LoadStatus? status,
    List<PhotoItem>? duplicates,
    String? errorMessage,
    double? progress,
    ScanMode? currentMode,
    ResultViewMode? viewMode,
    Map<String, List<PhotoItem>>? groupedResults,
    Set<String>? selectedPhotoIds,
  }) {
    return ScanState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
      currentMode: currentMode ?? this.currentMode,
      viewMode: viewMode ?? this.viewMode,
      groupedResults: groupedResults ?? this.groupedResults,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
    );
  }

  @override
  List<Object?> get props => [
    status,
    duplicates,
    errorMessage,
    progress,
    currentMode,
    viewMode,
    groupedResults,
    selectedPhotoIds,
  ];
}
