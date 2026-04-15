import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class OtherFeatureListItem extends StatelessWidget {
  final FeatureType featureType;
  const OtherFeatureListItem({super.key, required this.featureType});

  @override
  Widget build(BuildContext context) {
    return AppTransparentContainer(
      color: AppColors.secondary,
      child: Row(
        children: [
          Container(
            padding: 12.paddingAll,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.14),
              borderRadius: 16.borderRadius,
            ),
            child: const Icon(
              Icons.filter_none_rounded,
              color: AppColors.secondary,
            ),
          ),
          12.width,
          Expanded(
            child: Text(
              featureType.name
                  .replaceAllMapped(
                    RegExp(r'([A-Z])'),
                    (match) => ' ${match.group(0)}',
                  )
                  .trim(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ],
      ),
    );
  }
}
