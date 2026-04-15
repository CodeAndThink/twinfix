part of 'scan_cubit.dart';

class ScanState extends Equatable {
  final LoadStatus status;
  final List<PhotoItem> duplicates;
  final String? errorMessage;
  final double progress;
  final ScanMode currentMode;
  final bool isTutorialVisible;
  final int tutorialStepIndex;
  final Rect? tutorialTargetRect;

  const ScanState({
    required this.status,
    this.duplicates = const [],
    this.errorMessage,
    this.progress = 0.0,
    this.currentMode = ScanMode.deep,
    this.isTutorialVisible = false,
    this.tutorialStepIndex = 0,
    this.tutorialTargetRect,
  });

  factory ScanState.initial() => const ScanState(status: LoadStatus.initial);

  ScanState copyWith({
    LoadStatus? status,
    List<PhotoItem>? duplicates,
    String? errorMessage,
    double? progress,
    ScanMode? currentMode,
    bool? isTutorialVisible,
    int? tutorialStepIndex,
    Rect? tutorialTargetRect,
  }) {
    return ScanState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
      currentMode: currentMode ?? this.currentMode,
      isTutorialVisible: isTutorialVisible ?? this.isTutorialVisible,
      tutorialStepIndex: tutorialStepIndex ?? this.tutorialStepIndex,
      tutorialTargetRect: tutorialTargetRect,
    );
  }

  @override
  List<Object?> get props => [
    status,
    duplicates,
    errorMessage,
    progress,
    currentMode,
    isTutorialVisible,
    tutorialStepIndex,
    tutorialTargetRect,
  ];
}
