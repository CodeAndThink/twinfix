import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class OtherFeatureListItem extends StatelessWidget {
  final FeatureType featureType;
  const OtherFeatureListItem({super.key, required this.featureType});

  @override
  Widget build(BuildContext context) {
    return AppTransparentContainer(
      height: 48,
      padding: 12.paddingHorizontal,
      child: Row(
        children: [
          const Icon(Icons.filter_none_rounded, size: 18),
          12.width,
          Expanded(
            child: Text(
              featureType.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ],
      ),
    );
  }
}
