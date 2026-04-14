import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

class OtherFeatureListItem extends StatelessWidget {
  final FeatureType featureType;
  const OtherFeatureListItem({super.key, required this.featureType});

  @override
  Widget build(BuildContext context) {
    return DuolingoCard(child: Row(children: [Text(featureType.name)]));
  }
}
