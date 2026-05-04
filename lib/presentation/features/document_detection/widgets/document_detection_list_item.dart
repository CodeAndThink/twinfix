import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_entity_image.dart';

class DocumentDetectionListItem extends StatelessWidget {
  final MediaItem photo;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const DocumentDetectionListItem({
    super.key,
    required this.photo,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: 8.borderRadius,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: 8.borderRadius,
              child: AppAssetEntityImage(assetEntity: photo.assetEntity),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Container(
                padding: 4.paddingAll,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: 4.borderRadius,
                ),
                child: Text(
                  '${photo.width}x${photo.height}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                top: 4,
                right: 4,
                child: Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: 8.borderRadius,
                  border: isSelected
                      ? Border.all(color: theme.colorScheme.primary, width: 3)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
