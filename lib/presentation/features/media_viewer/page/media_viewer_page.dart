import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/media_viewer/cubit/media_viewer_cubit.dart';
import 'package:twinfix/presentation/features/media_viewer/cubit/media_viewer_state.dart';
import 'package:twinfix/presentation/features/media_viewer/navigator/media_viewer_navigator.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_entity_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:video_player/video_player.dart';

import 'package:twinfix/presentation/features/media_viewer/widgets/location_map_preview.dart';

class MediaViewerArgs {
  final MediaItem asset;

  const MediaViewerArgs({required this.asset});
}

class MediaViewerPage extends StatelessWidget {
  final MediaViewerArgs args;

  const MediaViewerPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaViewerCubit(
        navigator: MediaViewerNavigator(context),
        initialState: MediaViewerState.initial(args.asset),
      )..init(),
      child: const MediaViewerChildPage(),
    );
  }
}

class MediaViewerChildPage extends StatefulWidget {
  const MediaViewerChildPage({super.key});

  @override
  State<MediaViewerChildPage> createState() => _MediaViewerChildPageState();
}

class _MediaViewerChildPageState extends State<MediaViewerChildPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late S _l10n;
  late ThemeData _theme;
  late MediaViewerCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MediaViewerCubit>();
    _fadeController = AnimationController(
      vsync: this,
      duration: 300.milliseconds,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return BlocConsumer<MediaViewerCubit, MediaViewerState>(
      listener: (context, state) {
        if (state.showControls) {
          _fadeController.forward();
        } else {
          _fadeController.reverse();
        }
      },
      builder: (context, state) {
        final asset = state.asset;

        return AppScaffold(
          title: '',
          actions: [
            if (asset.mediaType.isVideo)
              _buildInfoChip(
                icon: Icons.videocam_rounded,
                label: '${asset.width}x${asset.height}',
              ),
            if (asset.mediaType.isAudio)
              _buildInfoChip(
                icon: Icons.audiotrack_rounded,
                label: _formatDuration(Duration(seconds: asset.duration)),
              ),
            if (asset.mediaType.isImage)
              _buildInfoChip(
                icon: Icons.photo_rounded,
                label: '${asset.width}x${asset.height}',
              ),
          ],
          body: Padding(
            padding: 12.paddingHorizontal,
            child: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Content
                  GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity != null) {
                        if (details.primaryVelocity! < -300) {
                          _showInfoSheet(state);
                        } else if (details.primaryVelocity! > 300) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    onTap: () {
                      if (asset.mediaType.isVideo || asset.mediaType.isAudio) {
                        _cubit.toggleControls();
                      }
                    },
                    child: _buildContent(state),
                  ),

                  // Bottom controls for video/audio
                  if ((asset.mediaType.isVideo || asset.mediaType.isAudio) &&
                      _cubit.videoController != null &&
                      _cubit.videoController!.value.isInitialized)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: FadeTransition(
                        opacity: _fadeController,
                        child: _buildBottomControls(state),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInfoSheet(MediaViewerState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final asset = state.asset;
        final sizeFormatted = state.fileSize != null
            ? '${(state.fileSize! / (1024 * 1024)).toStringAsFixed(2)} MB'
            : _l10n.unknown;
        final dateFormatted =
            '${asset.createDateTime.day}/${asset.createDateTime.month}/${asset.createDateTime.year} ${asset.createDateTime.hour.toString().padLeft(2, '0')}:${asset.createDateTime.minute.toString().padLeft(2, '0')}';

        return Padding(
          padding: 24.paddingAll,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.5),
                      borderRadius: 2.borderRadius,
                    ),
                  ),
                ),
                24.height,
                Text(
                  _l10n.information,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                16.height,
                _buildInfoRow(Icons.calendar_today_rounded, dateFormatted),
                12.height,
                _buildInfoRow(
                  Icons.aspect_ratio_rounded,
                  '${asset.width} x ${asset.height}',
                ),
                12.height,
                _buildInfoRow(Icons.sd_storage_rounded, sizeFormatted),
                if (state.latitude != null && state.longitude != null) ...[
                  12.height,
                  _buildInfoRow(
                    Icons.location_on_rounded,
                    '${state.latitude!.toStringAsFixed(4)}, ${state.longitude!.toStringAsFixed(4)}',
                  ),
                  LocationMapPreview(
                    latitude: state.latitude!,
                    longitude: state.longitude!,
                  ),
                ],
                24.height,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: _theme.colorScheme.primary),
        12.width,
        Expanded(child: Text(text, style: _theme.textTheme.bodyMedium)),
      ],
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _theme.colorScheme.primary.withValues(alpha: 0.15),
        borderRadius: 20.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _theme.colorScheme.primary, size: 16),
          6.width,
          Text(label, style: _theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildContent(MediaViewerState state) {
    if (state.status.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (state.status.isFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: _theme.colorScheme.error,
              size: 48,
            ),
            12.height,
            Text(
              _l10n.error_unable_to_play_media,
              style: _theme.textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    final asset = state.asset;
    switch (asset.mediaType) {
      case MediaType.image:
        return Padding(
          padding: 12.paddingAll,
          child: InteractiveViewer(
            child: AppAssetEntityImage(
              assetEntity: asset.assetEntity,
              isOriginal: true,
              fit: BoxFit.contain,
            ),
          ),
        );

      case MediaType.video:
        return _buildVideoPlayer(state);

      case MediaType.audio:
        return _buildAudioPlayer(state);

      default:
        return Center(
          child: Text(
            _l10n.error_unsupported_media_type,
            style: _theme.textTheme.titleMedium,
          ),
        );
    }
  }

  Widget _buildVideoPlayer(MediaViewerState state) {
    final controller = _cubit.videoController;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: AspectRatio(
        aspectRatio: state.aspectRatio ?? controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(controller),
            // Play/Pause overlay
            if (state.showControls)
              GestureDetector(
                onTap: _cubit.togglePlayPause,
                child: AnimatedOpacity(
                  opacity: state.showControls ? 1.0 : 0.0,
                  duration: 200.milliseconds,
                  child: Container(
                    padding: 16.paddingAll,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      state.isPlaying
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

  Widget _buildAudioPlayer(MediaViewerState state) {
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
                  _theme.colorScheme.primary.withValues(alpha: 0.8),
                  _theme.colorScheme.tertiary.withValues(alpha: 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: _theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: IconButton(
              onPressed: _cubit.togglePlayPause,
              icon: Icon(
                state.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 64,
              ),
            ),
          ),
          32.height,

          // Title
          if (state.asset.title != null)
            Padding(
              padding: 16.paddingHorizontal,
              child: Text(
                state.asset.title!,
                style: _theme.textTheme.titleLarge?.copyWith(
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

  Widget _buildBottomControls(MediaViewerState state) {
    final position = state.position;
    final duration = state.duration;
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
              activeTrackColor: _theme.colorScheme.primary,
              inactiveTrackColor: Colors.white24,
              thumbColor: _theme.colorScheme.primary,
              overlayColor: _theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: (value) {
                final newPosition = Duration(
                  milliseconds: (value * duration.inMilliseconds).toInt(),
                );
                _cubit.seekTo(newPosition);
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
                  style: _theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  _formatDuration(duration),
                  style: _theme.textTheme.bodySmall?.copyWith(
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
