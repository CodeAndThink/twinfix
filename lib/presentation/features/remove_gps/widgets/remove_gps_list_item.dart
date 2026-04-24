import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class RemoveGPSListItem extends StatelessWidget {
  final MediaItem photo;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const RemoveGPSListItem({
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
              child: photo.assetEntity != null
                  ? AssetEntityImage(
                      photo.assetEntity!,
                      thumbnailSize: const ThumbnailSize.square(200),
                      isOriginal: false,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
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
