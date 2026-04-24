part of 'scan_cubit.dart';

class ScanState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> duplicates;
  final String? errorMessage;
  final ScanMode currentMode;
  final bool isTutorialVisible;
  final int tutorialStepIndex;
  final Rect? tutorialTargetRect;

  const ScanState({
    required this.status,
    this.duplicates = const [],
    this.errorMessage,
    this.currentMode = ScanMode.deep,
    this.isTutorialVisible = false,
    this.tutorialStepIndex = 0,
    this.tutorialTargetRect,
  });

  factory ScanState.initial() => const ScanState(status: LoadStatus.initial);

  ScanState copyWith({
    LoadStatus? status,
    List<MediaItem>? duplicates,
    String? errorMessage,
    ScanMode? currentMode,
    bool? isTutorialVisible,
    int? tutorialStepIndex,
    Rect? tutorialTargetRect,
  }) {
    return ScanState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      errorMessage: errorMessage ?? this.errorMessage,
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
        currentMode,
        isTutorialVisible,
        tutorialStepIndex,
        tutorialTargetRect,
      ];
}
