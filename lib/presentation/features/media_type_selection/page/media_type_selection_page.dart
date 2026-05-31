import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/media_type_selection/cubit/media_type_selection_cubit.dart';
import 'package:twinfix/presentation/features/media_type_selection/navigator/media_type_selection_navigator.dart';
import 'package:twinfix/presentation/features/media_type_selection/widgets/media_type_selection_list_item.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class MediaTypeSelectionPage extends StatelessWidget {
  const MediaTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaTypeSelectionCubit(
        navigator: MediaTypeSelectionNavigator(context),
      ),
      child: const MediaTypeSelectionChildPage(),
    );
  }
}

class MediaTypeSelectionChildPage extends StatefulWidget {
  const MediaTypeSelectionChildPage({super.key});

  @override
  State<MediaTypeSelectionChildPage> createState() =>
      _MediaTypeSelectionChildPageState();
}

class _MediaTypeSelectionChildPageState
    extends State<MediaTypeSelectionChildPage> {
  late final MediaTypeSelectionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MediaTypeSelectionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: S.current.media_type_selection,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: 12.paddingAll,
      child: ListView.separated(
        itemCount: MediaType.values.length,
        separatorBuilder: (context, index) => 12.height,
        itemBuilder: (context, index) {
          return MediaTypeSelectionListItem(
            mediaType: MediaType.values[index],
            onTap: () =>
                _cubit.handleItemTap(mediaType: MediaType.values[index]),
          );
        },
      ),
    );
  }
}
