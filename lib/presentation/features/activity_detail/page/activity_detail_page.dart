import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/widgets/buttons/app_scroll_to_top_button.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/achievement/widgets/contributed_graph.dart';
import 'package:twinfix/presentation/features/activity_detail/widgets/history_list_item.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import '../cubit/activity_detail_cubit.dart';
import '../cubit/activity_detail_state.dart';
import '../navigator/activity_detail_navigator.dart';

class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityDetailCubit(
        authRepository: locator(),
        navigator: ActivityDetailNavigator(context),
      ),
      child: const ActivityDetailChildPage(),
    );
  }
}

class ActivityDetailChildPage extends StatefulWidget {
  const ActivityDetailChildPage({super.key});

  @override
  State<ActivityDetailChildPage> createState() =>
      _ActivityDetailChildPageState();
}

class _ActivityDetailChildPageState extends State<ActivityDetailChildPage> {
  late final ActivityDetailCubit _cubit;
  late S _l10n;
  late ThemeData _theme;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollToTopNotifier = ValueNotifier<bool>(
    false,
  );

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ActivityDetailCubit>();
    _cubit.init();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      if (_showScrollToTopNotifier.value != show) {
        _showScrollToTopNotifier.value = show;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _showScrollToTopNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.activityDetailTitle,
      floatingActionButton: AppScrollToTopButton(
        scrollController: _scrollController,
        showNotifier: _showScrollToTopNotifier,
      ),
      body: BlocBuilder<ActivityDetailCubit, ActivityDetailState>(
        builder: (context, state) {
          if (state.status.isLoading && state.history.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isFailure) {
            return Center(
              child: Text(
                _l10n.error(state.errorMessage ?? ""),
                style: _theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _cubit.init(),
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
                  AppTitleHeader(title: _l10n.contributionGraph),
                  AppTransparentContainer(
                    child: ContributedGraph(history: state.history),
                  ),
                  AppTitleHeader(
                    title: _l10n.history,
                    action: state.history.isNotEmpty
                        ? _buildOpenHistoryButton(state: state)
                        : null,
                  ),
                  if (state.history.isEmpty)
                    Center(
                      child: Padding(
                        padding: 40.paddingVertical,
                        child: Text(
                          _l10n.noActivity,
                          style: _theme.textTheme.titleSmall?.copyWith(
                            color: _theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  else ...[
                    AppTransparentContainer(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: Column(
                        children: [
                          if (state.history.length > AppConfigs.maxHistoryItems)
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.transparent],
                                  stops: [0.6, 1.0],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Column(
                                children: List.generate(
                                  AppConfigs.maxHistoryItems,
                                  (index) {
                                    return HistoryListItem(
                                      history: state.history[index],
                                    );
                                  },
                                ),
                              ),
                            )
                          else
                            ...List.generate(state.history.length, (index) {
                              return HistoryListItem(
                                history: state.history[index],
                              );
                            }),
                          if (state.history.length >
                              AppConfigs.maxHistoryItems) ...[
                            Padding(
                              padding: 12.paddingVertical,
                              child: Align(
                                alignment: Alignment.center,
                                child: _buildOpenHistoryButton(state: state),
                              ),
                            ),
                          ],
                        ],
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

  Widget _buildOpenHistoryButton({required ActivityDetailState state}) {
    return GestureDetector(
      onTap: () => _cubit.navigator.goToHistory(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _l10n.viewFullHistory,
            style: _theme.textTheme.bodyMedium?.copyWith(
              color: _theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          4.width,
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: _theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
