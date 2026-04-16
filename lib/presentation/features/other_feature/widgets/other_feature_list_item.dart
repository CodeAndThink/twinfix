import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class OtherFeatureListItem extends StatelessWidget {
  final PhotoType photoType;
  final VoidCallback onTap;

  const OtherFeatureListItem({
    super.key,
    required this.photoType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppTransparentContainer(
      height: 64,
      padding: 12.paddingHorizontal,
      onTap: onTap,
      child: Row(
        children: [
          _buildIcon(context),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(photoType.title, style: theme.textTheme.titleMedium),
                4.height,
                Text(
                  photoType.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: 8.paddingAll,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: 12.borderRadius,
      ),
      child: Icon(photoType.icon, size: 24, color: theme.colorScheme.primary),
    );
  }
}
