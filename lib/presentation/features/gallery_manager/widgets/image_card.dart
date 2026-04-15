import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/utils/file_utils.dart';

class ImageCard extends StatelessWidget {
  final AssetEntity photo;
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
          colors: [
            theme.colorScheme.surface,
            // AppColors.surfaceAlt.withValues(alpha: 0.84),
          ],
        ),
        borderRadius: borderRadius,
        border: Border.all(
          color: isSelected ? theme.colorScheme.error : AppColors.glassStroke,
          width: isSelected ? 2.5 : 1.25,
        ),
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
              child: AssetEntityImage(
                photo,
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(400),
                fit: BoxFit.cover,
              ),
            ),
            if (photo.type == AssetType.video || photo.type == AssetType.audio)
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.72),
                      Colors.black.withValues(alpha: 0.24),
                    ],
                  ),
                ),
                child: Text(
                  "${photo.type == AssetType.audio ? 'Audio' : '${photo.width}x${photo.height}'}${fileSize != null ? ' • ${FileUtils.formatBytes(fileSize!)}' : ''}",
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
            ],
          ],
        ),
      ),
    );
  }
}
