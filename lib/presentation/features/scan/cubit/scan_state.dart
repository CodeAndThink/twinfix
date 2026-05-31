part of 'scan_cubit.dart';

class ScanState extends Equatable {
  final ScanMode currentMode;
  final bool isTutorialVisible;
  final int tutorialStepIndex;
  final Rect? tutorialTargetRect;

  const ScanState({
    this.currentMode = ScanMode.deep,
    this.isTutorialVisible = false,
    this.tutorialStepIndex = 0,
    this.tutorialTargetRect,
  });

  factory ScanState.initial() => const ScanState();

  ScanState copyWith({
    ScanMode? currentMode,
    bool? isTutorialVisible,
    int? tutorialStepIndex,
    Rect? tutorialTargetRect,
  }) {
    return ScanState(
      currentMode: currentMode ?? this.currentMode,
      isTutorialVisible: isTutorialVisible ?? this.isTutorialVisible,
      tutorialStepIndex: tutorialStepIndex ?? this.tutorialStepIndex,
      tutorialTargetRect: tutorialTargetRect,
    );
  }

  @override
  List<Object?> get props => [
    currentMode,
    isTutorialVisible,
    tutorialStepIndex,
    tutorialTargetRect,
  ];
}
