import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/enums/feature_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class OtherFeatureListItem extends StatelessWidget {
  final FeatureItem feature;
  final VoidCallback onTap;

  const OtherFeatureListItem({
    super.key,
    required this.feature,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppTransparentContainer(
      height: 64,
      padding: 12.paddingHorizontal.copyWith(top: 8, bottom: 8),
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
                Text(feature.title, style: theme.textTheme.titleMedium),
                const Spacer(),
                Text(
                  feature.description,
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
        borderRadius: 10.borderRadius,
      ),
      child: Icon(feature.icon, size: 24, color: theme.colorScheme.primary),
    );
  }
}
