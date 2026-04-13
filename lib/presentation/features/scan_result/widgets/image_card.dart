import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/domain/entities/photo_item.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';

class ImageCard extends StatelessWidget {
  final PhotoItem photo;
  final bool isSelected;
  const ImageCard({super.key, required this.photo, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppSizes.borderRadius.borderRadius,
        border: isSelected
            ? Border.all(color: theme.colorScheme.error, width: 4)
            : null,
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? AppColors.cardShadow
                : Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: AppSizes.borderRadius.borderRadius,
              child: AppFileImage(path: photo.path),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: 4.paddingAll,
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 24),
              ),
            ),
        ],
      ),
    );
  }
}
