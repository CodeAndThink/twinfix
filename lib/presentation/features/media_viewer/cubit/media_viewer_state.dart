import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class MediaViewerState extends Equatable {
  final LoadStatus status;
  final MediaItem asset;
  final bool showControls;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String? errorMessage;
  final double? aspectRatio;
  final double? latitude;
  final double? longitude;
  final int? fileSize;

  const MediaViewerState({
    required this.status,
    required this.asset,
    this.showControls = true,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.errorMessage,
    this.aspectRatio,
    this.latitude,
    this.longitude,
    this.fileSize,
  });

  factory MediaViewerState.initial(MediaItem asset) {
    return MediaViewerState(status: LoadStatus.initial, asset: asset);
  }

  MediaViewerState copyWith({
    LoadStatus? status,
    MediaItem? asset,
    bool? showControls,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? errorMessage,
    double? aspectRatio,
    double? latitude,
    double? longitude,
    int? fileSize,
  }) {
    return MediaViewerState(
      status: status ?? this.status,
      asset: asset ?? this.asset,
      showControls: showControls ?? this.showControls,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      errorMessage: errorMessage ?? this.errorMessage,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  @override
  List<Object?> get props => [
    status,
    asset,
    showControls,
    isPlaying,
    position,
    duration,
    errorMessage,
    aspectRatio,
    latitude,
    longitude,
    fileSize,
  ];
}
