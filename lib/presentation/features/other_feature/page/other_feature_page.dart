import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/other_feature/cubit/other_feature_cubit.dart';
import 'package:twinfix/presentation/features/other_feature/navigator/other_feature_navigator.dart';
import 'package:twinfix/presentation/features/other_feature/widgets/other_feature_list_item.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';

class OtherFeaturePage extends StatelessWidget {
  const OtherFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherFeatureCubit(
        navigator: OtherFeatureNavigator(context),
        photoRepository: locator<PhotoRepository>(),
      ),
      child: const OtherFeatureChildPage(),
    );
  }
}

class OtherFeatureChildPage extends StatefulWidget {
  const OtherFeatureChildPage({super.key});

  @override
  State<OtherFeatureChildPage> createState() => _OtherFeatureChildPageState();
}

class _OtherFeatureChildPageState extends State<OtherFeatureChildPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: S.of(context).tabOtherFeatures,
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: 12.paddingAll,
      child: ListView.builder(
        itemCount: FeatureType.values.length,
        itemBuilder: (context, index) {
          final type = FeatureType.values[index];
          return OtherFeatureListItem(
            featureType: type,
            onTap: () => context.read<OtherFeatureCubit>().onFeatureTap(type),
          );
        },
      ),
    );
  }
}
