import 'dart:async';
import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/media_viewer/cubit/media_viewer_state.dart';
import 'package:twinfix/presentation/features/media_viewer/navigator/media_viewer_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class MediaViewerCubit extends BaseCubit<MediaViewerState> {
  final MediaViewerNavigator navigator;
  VideoPlayerController? _videoController;
  Timer? _hideControlsTimer;

  MediaViewerCubit({
    required this.navigator,
    required MediaViewerState initialState,
  }) : super(initialState);

  VideoPlayerController? get videoController => _videoController;

  void init() {
    if (state.asset.mediaType.isVideo || state.asset.mediaType.isAudio) {
      _initMediaPlayer();
    } else {
      safeEmit(state.copyWith(status: LoadStatus.success));
    }
  }

  Future<void> _initMediaPlayer() async {
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final File file = File(state.asset.path);
      _videoController = VideoPlayerController.file(file);
      await _videoController!.initialize();

      _videoController!.addListener(_onPlayerUpdate);
      await _videoController!.play();

      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          duration: _videoController!.value.duration,
          isPlaying: _videoController!.value.isPlaying,
          aspectRatio: _videoController!.value.aspectRatio,
        ),
      );

      _startHideControlsTimer();
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void _onPlayerUpdate() {
    if (_videoController == null) return;

    final value = _videoController!.value;
    if (state.isPlaying != value.isPlaying ||
        state.position.inSeconds != value.position.inSeconds ||
        state.duration != value.duration) {
      safeEmit(
        state.copyWith(
          isPlaying: value.isPlaying,
          position: value.position,
          duration: value.duration,
        ),
      );
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(3.seconds, () {
      if (state.showControls && state.isPlaying) {
        safeEmit(state.copyWith(showControls: false));
      }
    });
  }

  void toggleControls() {
    final newShowControls = !state.showControls;
    safeEmit(state.copyWith(showControls: newShowControls));
    if (newShowControls) {
      _startHideControlsTimer();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  void togglePlayPause() {
    if (_videoController == null) return;

    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
      safeEmit(state.copyWith(showControls: true, isPlaying: false));
      _hideControlsTimer?.cancel();
    } else {
      _videoController!.play();
      safeEmit(state.copyWith(isPlaying: true));
      _startHideControlsTimer();
    }
  }

  void seekTo(Duration position) {
    _videoController?.seekTo(position);
    safeEmit(state.copyWith(position: position));
  }

  @override
  Future<void> close() {
    _hideControlsTimer?.cancel();
    _videoController?.removeListener(_onPlayerUpdate);
    _videoController?.dispose();
    return super.close();
  }
}
