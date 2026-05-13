import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import '../../../../domain/entities/media_item.dart';

class ScanLoadingState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> duplicates;
  final int scanProgress;
  final int scanTotal;
  final String? errorMessage;
  final ScanMode currentMode;

  const ScanLoadingState({
    this.status = LoadStatus.initial,
    this.duplicates = const [],
    this.scanProgress = 0,
    this.scanTotal = 0,
    this.errorMessage,
    this.currentMode = ScanMode.deep,
  });

  ScanLoadingState copyWith({
    LoadStatus? status,
    List<MediaItem>? duplicates,
    int? scanProgress,
    int? scanTotal,
    String? errorMessage,
    ScanMode? currentMode,
  }) {
    return ScanLoadingState(
      status: status ?? this.status,
      duplicates: duplicates ?? this.duplicates,
      scanProgress: scanProgress ?? this.scanProgress,
      scanTotal: scanTotal ?? this.scanTotal,
      errorMessage: errorMessage ?? this.errorMessage,
      currentMode: currentMode ?? this.currentMode,
    );
  }

  @override
  List<Object?> get props => [
    status,
    duplicates,
    scanProgress,
    scanTotal,
    errorMessage,
    currentMode,
  ];
}
