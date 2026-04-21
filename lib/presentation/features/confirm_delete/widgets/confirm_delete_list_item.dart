import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class ConfirmDeleteListItem extends StatelessWidget {
  final MediaItem item;
  final VoidCallback? onRemove;

  const ConfirmDeleteListItem({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: 12.borderRadius,
          child: item.assetEntity != null
              ? AssetEntityImage(
                  item.assetEntity!,
                  thumbnailSize: ThumbnailSize.square(200),
                  isOriginal: false,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: 4.paddingAll,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
