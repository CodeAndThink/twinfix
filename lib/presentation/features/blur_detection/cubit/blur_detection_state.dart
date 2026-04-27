import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class BlurDetectionState extends Equatable {
  final LoadStatus status;
  final List<MediaItem> blurryAssets;
  final int scanProgress;
  final int scanTotal;
  final String? errorMessage;

  const BlurDetectionState({
    this.status = LoadStatus.initial,
    this.blurryAssets = const [],
    this.scanProgress = 0,
    this.scanTotal = 0,
    this.errorMessage,
  });

  BlurDetectionState copyWith({
    LoadStatus? status,
    List<MediaItem>? blurryAssets,
    int? scanProgress,
    int? scanTotal,
    String? errorMessage,
  }) {
    return BlurDetectionState(
      status: status ?? this.status,
      blurryAssets: blurryAssets ?? this.blurryAssets,
      scanProgress: scanProgress ?? this.scanProgress,
      scanTotal: scanTotal ?? this.scanTotal,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    blurryAssets,
    scanProgress,
    scanTotal,
    errorMessage,
  ];
}
