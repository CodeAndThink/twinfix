import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/domain/enums/other_feature.dart';
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
  late final OtherFeatureCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OtherFeatureCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.tabOtherFeatures,
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.of(context).padding.top + 75 + 12,
        12,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        children: [
          ..._cubit.items.map(
            (type) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OtherFeatureListItem(
                feature: type,
                onTap: () => _cubit.onFeatureTap(
                  photoType: type,
                  mediaType: type.mediaType,
                ),
              ),
            ),
          ),
          ...OtherFeature.values.map(
            (type) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OtherFeatureListItem(
                feature: type,
                onTap: () => _cubit.onOtherFeatureTap(type),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
