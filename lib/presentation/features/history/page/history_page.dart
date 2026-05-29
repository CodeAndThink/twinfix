import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/widgets/buttons/app_scroll_to_top_button.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/activity_detail/widgets/history_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';
import 'history_loading_page.dart';

enum TimeMarker { today, yesterday, last7Days, thisMonth, earlier }

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollToTopNotifier = ValueNotifier<bool>(
    false,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      if (_showScrollToTopNotifier.value != show) {
        _showScrollToTopNotifier.value = show;
      }
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<HistoryCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _showScrollToTopNotifier.dispose();
    super.dispose();
  }

  Map<TimeMarker, List<DeletionHistory>> _groupHistory(
    List<DeletionHistory> history,
  ) {
    final Map<TimeMarker, List<DeletionHistory>> grouped = {
      TimeMarker.today: [],
      TimeMarker.yesterday: [],
      TimeMarker.last7Days: [],
      TimeMarker.thisMonth: [],
      TimeMarker.earlier: [],
    };

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final sevenDaysAgo = today.subtract(const Duration(days: 7));
    final startOfMonth = DateTime(now.year, now.month, 1);

    for (final item in history) {
      final itemDate = DateTime(
        item.timestamp.year,
        item.timestamp.month,
        item.timestamp.day,
      );

      if (itemDate == today) {
        grouped[TimeMarker.today]!.add(item);
      } else if (itemDate == yesterday) {
        grouped[TimeMarker.yesterday]!.add(item);
      } else if (itemDate.isAfter(sevenDaysAgo)) {
        grouped[TimeMarker.last7Days]!.add(item);
      } else if (itemDate.isAfter(startOfMonth) || itemDate == startOfMonth) {
        grouped[TimeMarker.thisMonth]!.add(item);
      } else {
        grouped[TimeMarker.earlier]!.add(item);
      }
    }

    return grouped;
  }

  String _getTimeMarkerLabel(BuildContext context, TimeMarker marker) {
    final l10n = S.of(context);
    switch (marker) {
      case TimeMarker.today:
        return l10n.historyToday;
      case TimeMarker.yesterday:
        return l10n.historyYesterday;
      case TimeMarker.last7Days:
        return l10n.historyLast7Days;
      case TimeMarker.thisMonth:
        return l10n.historyThisMonth;
      case TimeMarker.earlier:
        return l10n.historyEarlier;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppScaffold(
      title: l10n.history,
      floatingActionButton: AppScrollToTopButton(
        scrollController: _scrollController,
        showNotifier: _showScrollToTopNotifier,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.status.isLoading && state.history.isEmpty) {
            return const HistoryLoadingPage();
          }

          if (state.status.isFailure && state.history.isEmpty) {
            return Center(
              child: Text(
                l10n.error(state.errorMessage ?? ""),
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            );
          }

          if (state.history.isEmpty) {
            return Center(
              child: Text(
                l10n.noActivity,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }

          final grouped = _groupHistory(state.history);

          return RefreshIndicator(
            onRefresh: () => context.read<HistoryCubit>().init(),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                12,
                MediaQuery.of(context).padding.top,
                12,
                MediaQuery.of(context).padding.bottom + 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...TimeMarker.values.map((marker) {
                    final items = grouped[marker]!;
                    if (items.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleHeader(
                          title: _getTimeMarkerLabel(context, marker),
                        ),
                        AppTransparentContainer(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                          child: Column(
                            children: items.map((item) {
                              return HistoryListItem(history: item);
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                  if (state.hasMore) ...[
                    20.height,
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
