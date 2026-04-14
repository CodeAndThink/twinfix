import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:video_player/video_player.dart';

class MediaViewerArgs {
  final AssetEntity asset;

  const MediaViewerArgs({required this.asset});
}

class MediaViewerPage extends StatefulWidget {
  final MediaViewerArgs args;

  const MediaViewerPage({super.key, required this.args});

  @override
  State<MediaViewerPage> createState() => _MediaViewerPageState();
}

class _MediaViewerPageState extends State<MediaViewerPage>
    with SingleTickerProviderStateMixin {
  AssetEntity get asset => widget.args.asset;

  VideoPlayerController? _videoController;
  bool _isLoading = true;
  bool _hasError = false;
  bool _showControls = true;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    );

    if (asset.type == AssetType.video || asset.type == AssetType.audio) {
      _initMediaPlayer();
    } else {
      _isLoading = false;
    }
  }

  Future<void> _initMediaPlayer() async {
    try {
      final File? file = await asset.file;
      if (file == null || !mounted) return;

      _videoController = VideoPlayerController.file(file);
      await _videoController!.initialize();

      if (!mounted) return;

      _videoController!.addListener(_onPlayerUpdate);
      await _videoController!.play();

      setState(() {
        _isLoading = false;
      });

      // Auto-hide controls after 3 seconds
      _startHideControlsTimer();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  void _onPlayerUpdate() {
    if (!mounted) return;
    setState(() {});
  }

  void _startHideControlsTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted &&
          _showControls &&
          (_videoController?.value.isPlaying ?? false)) {
        setState(() => _showControls = false);
        _fadeController.reverse();
      }
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) {
      _fadeController.forward();
      _startHideControlsTimer();
    } else {
      _fadeController.reverse();
    }
  }

  void _togglePlayPause() {
    if (_videoController == null) return;
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
      setState(() => _showControls = true);
      _fadeController.forward();
    } else {
      _videoController!.play();
      _startHideControlsTimer();
    }
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _videoController?.removeListener(_onPlayerUpdate);
    _videoController?.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Content
            GestureDetector(
              onTap: () {
                if (asset.type == AssetType.video ||
                    asset.type == AssetType.audio) {
                  _toggleControls();
                }
              },
              child: _buildContent(theme),
            ),

            // Top bar (always visible)
            Positioned(top: 0, left: 0, right: 0, child: _buildTopBar(theme)),

            // Bottom controls for video/audio
            if ((asset.type == AssetType.video ||
                    asset.type == AssetType.audio) &&
                _videoController != null &&
                _videoController!.value.isInitialized)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _fadeController,
                  child: _buildBottomControls(theme),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s8,
        vertical: AppSizes.s8,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Spacer(),
          if (asset.type == AssetType.video)
            _buildInfoChip(
              Icons.videocam_rounded,
              '${asset.width}x${asset.height}',
              theme,
            ),
          if (asset.type == AssetType.audio)
            _buildInfoChip(
              Icons.audiotrack_rounded,
              _formatDuration(Duration(seconds: asset.duration)),
              theme,
            ),
          if (asset.type == AssetType.image)
            _buildInfoChip(
              Icons.photo_rounded,
              '${asset.width}x${asset.height}',
              theme,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            AppSizes.s12.height,
            Text(
              'Unable to play media',
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      );
    }

    switch (asset.type) {
      case AssetType.image:
        return InteractiveViewer(
          child: Center(
            child: AssetEntityImage(
              asset,
              isOriginal: true,
              fit: BoxFit.contain,
            ),
          ),
        );

      case AssetType.video:
        return _buildVideoPlayer(theme);

      case AssetType.audio:
        return _buildAudioPlayer(theme);

      default:
        return Center(
          child: Text(
            'Unsupported media type',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        );
    }
  }

  Widget _buildVideoPlayer(ThemeData theme) {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_videoController!),
            // Play/Pause overlay
            if (_showControls)
              GestureDetector(
                onTap: _togglePlayPause,
                child: AnimatedOpacity(
                  opacity: _showControls ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _videoController!.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPlayer(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Audio icon with animated ring
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                  theme.colorScheme.tertiary.withValues(alpha: 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: IconButton(
              onPressed: _togglePlayPause,
              icon: Icon(
                _videoController?.value.isPlaying == true
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 64,
              ),
            ),
          ),
          AppSizes.s32.height,

          // Title
          if (asset.title != null)
            Padding(
              padding: AppSizes.s16.paddingHorizontal,
              child: Text(
                asset.title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(ThemeData theme) {
    final position = _videoController!.value.position;
    final duration = _videoController!.value.duration;
    final progress = duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: theme.colorScheme.primary,
              inactiveTrackColor: Colors.white24,
              thumbColor: theme.colorScheme.primary,
              overlayColor: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: (value) {
                final newPosition = Duration(
                  milliseconds: (value * duration.inMilliseconds).toInt(),
                );
                _videoController!.seekTo(newPosition);
              },
            ),
          ),

          // Time labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(position),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  _formatDuration(duration),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
