import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/achievement/widgets/app_heatmap.dart';
import 'package:twinfix/presentation/features/achievement/widgets/history_list_item.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ActivityDetailCubit>();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.activityDetailTitle,
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
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                12,
                MediaQuery.of(context).padding.top + 12,
                12,
                MediaQuery.of(context).padding.bottom + 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(title: _l10n.contributionGraph),
                  12.height,
                  AppHeatMap(history: state.history),
                  32.height,
                  _buildSectionHeader(title: _l10n.history),
                  12.height,
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
                  else
                    ...List.generate(state.history.length, (index) {
                      return HistoryListItem(history: state.history[index]);
                    }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({required String title}) {
    return Text(
      title.toUpperCase(),
      style: _theme.textTheme.labelLarge?.copyWith(
        color: _theme.colorScheme.primary,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
