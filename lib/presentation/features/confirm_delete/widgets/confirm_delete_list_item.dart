import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_entity_image.dart';

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
          borderRadius: 8.borderRadius,
          child: AppAssetEntityImage(assetEntity: item.assetEntity),
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
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: 8.borderRadius,
              border: Border.all(
                color: Theme.of(context).colorScheme.error,
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
