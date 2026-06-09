import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/media_timeline/widgets/media_timeline_segment_button.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

import '../cubit/media_timeline_cubit.dart';
import '../cubit/media_timeline_state.dart';
import '../navigator/media_timeline_navigator.dart';
import '../widgets/media_timeline_list_item.dart';
import 'media_timeline_loading_page.dart';

class MediaTimelinePage extends StatelessWidget {
  const MediaTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaTimelineCubit(
        photoRepository: locator(),
        navigator: MediaTimelineNavigator(context),
      ),
      child: const MediaTimelineChildPage(),
    );
  }
}

class MediaTimelineChildPage extends StatefulWidget {
  const MediaTimelineChildPage({super.key});

  @override
  State<MediaTimelineChildPage> createState() => _MediaTimelineChildPageState();
}

class _MediaTimelineChildPageState extends State<MediaTimelineChildPage> {
  late final MediaTimelineCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MediaTimelineCubit>();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.mediaTimeline,
      actions: [
        BlocBuilder<MediaTimelineCubit, MediaTimelineState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(Icons.sort_rounded),
              onPressed: () {
                _cubit.navigator.showSortOptionsSheet(
                  sortTypes: [
                    SortType.dateDesc,
                    SortType.dateAsc,
                    SortType.countDesc,
                    SortType.countAsc,
                  ],
                  selectedValue: state.sortType,
                  onSelected: (sortType) =>
                      _cubit.changeSortType(sortType: sortType),
                );
              },
            );
          },
        ),
      ],
      body: BlocBuilder<MediaTimelineCubit, MediaTimelineState>(
        builder: (context, state) {
          if (state.status.isLoading || state.status.isInitial) {
            return const MediaTimelineLoadingPage();
          }

          if (state.status.isFailure) {
            return Center(
              child: Text(
                state.errorMessage ?? _l10n.defaultErrorMessage,
                style: TextStyle(color: _theme.colorScheme.error),
              ),
            );
          }

          if (state.groupedItems.isEmpty) {
            return _buildEmptyUI();
          }

          return SafeArea(
            bottom: false,
            child: Padding(
              padding: 12.paddingHorizontal,
              child: Column(
                children: [
                  _buildToggleButtons(context, state),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.groupedItems.length,
                      separatorBuilder: (context, index) => 12.height,
                      itemBuilder: (context, index) {
                        final key = state.groupedItems.keys.elementAt(index);
                        final items = state.groupedItems[key]!;
                        return MediaTimelineListItem(
                          title: key,
                          count: items.length,
                          onTap: () {
                            _cubit.onGroupTap(items);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 52,
            color: _theme.colorScheme.primary,
          ),
          16.height,
          Text(
            _l10n.perfect,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: _theme.colorScheme.primary,
            ),
          ),
          8.height,
          Text(
            _l10n.deviceIsClean,
            textAlign: TextAlign.center,
            style: _theme.textTheme.bodyMedium,
          ),
          24.height,
          AppFilledButton(
            onPressed: () => _cubit.navigator.safePop(),
            text: _l10n.back,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context, MediaTimelineState state) {
    return Padding(
      padding: 16.paddingAll,
      child: MediaTimelineSegmentButton(
        selectedMode: state.mode,
        onChanged: (mode) {
          _cubit.changeMode(mode);
        },
        dayLabel: _l10n.timelineDay,
        monthLabel: _l10n.timelineMonth,
        yearLabel: _l10n.timelineYear,
      ),
    );
  }
}
