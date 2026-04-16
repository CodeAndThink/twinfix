import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class OtherFeatureListItem extends StatelessWidget {
  final FeatureType featureType;
  final VoidCallback onTap;

  const OtherFeatureListItem({
    super.key,
    required this.featureType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppTransparentContainer(
      height: 64, // Increased height for better tap target and description
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
                Text(
                  _getTitle(context),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.height,
                Text(
                  _getDescription(context),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
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
    IconData iconData;
    switch (featureType) {
      case FeatureType.duplicatePhoto:
        iconData = Icons.copy_all_rounded;
        break;
      case FeatureType.blurryPhoto:
        iconData = Icons.blur_on_rounded;
        break;
    }
    return Container(
      padding: 8.paddingAll,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, size: 24, color: Theme.of(context).primaryColor),
    );
  }

  String _getTitle(BuildContext context) {
    switch (featureType) {
      case FeatureType.duplicatePhoto:
        return S.of(context).deleteDuplicates;
      case FeatureType.blurryPhoto:
        return S.of(context).blurryPhotos;
    }
  }

  String _getDescription(BuildContext context) {
    switch (featureType) {
      case FeatureType.duplicatePhoto:
        return S.of(context).deleteDuplicatesMessage(0); // Placeholder count
      case FeatureType.blurryPhoto:
        return S.of(context).blurryPhotosDescription;
    }
  }
}
