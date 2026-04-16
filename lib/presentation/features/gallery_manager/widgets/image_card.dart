import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/utils/file_utils.dart';

import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';

class ImageCard extends StatelessWidget {
  final MediaItem photo;
  final bool isSelected;
  final int? fileSize;

  const ImageCard({
    super.key,
    required this.photo,
    required this.isSelected,
    this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = 12.borderRadius;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.surface, theme.colorScheme.surfaceBright],
        ),
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? theme.colorScheme.error.withValues(alpha: 0.24)
                : AppColors.seed.withValues(alpha: 0.12),
            blurRadius: 22,
            spreadRadius: -8,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: photo.path.isNotEmpty
                  ? AppFileImage(path: photo.path, fit: BoxFit.cover)
                  : photo.assetEntity != null
                  ? AssetEntityImage(
                      photo.assetEntity!,
                      thumbnailSize: ThumbnailSize.square(300),
                      isOriginal: false,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
            if (photo.mediaType.isVideo || photo.mediaType.isAudio)
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: 8.paddingAll,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: 8.paddingAll,
                color: Colors.black87,
                child: Text(
                  "${photo.mediaType.isAudio ? 'Audio' : '${photo.width}x${photo.height}'}${fileSize != null ? ' • ${FileUtils.formatBytes(fileSize!)}' : ''}",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (isSelected) ...[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: theme.colorScheme.error.withValues(alpha: 0.12),
                    border: Border.all(
                      color: theme.colorScheme.error,
                      width: 3,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: 4.paddingAll,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ] else ...[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: theme.colorScheme.primary,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
