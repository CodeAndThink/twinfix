import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/presentation/features/scan_result/navigator/scan_result_navigator.dart';
import 'package:twinfix/presentation/features/scan_result/widgets/scan_result_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import '../../../../domain/entities/media_item.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_result_cubit.dart';
import '../cubit/scan_result_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/extensions.dart';

class ScanResultPageArgs {
  final List<MediaItem> initialDuplicates;

  const ScanResultPageArgs({required this.initialDuplicates});
}

class ScanResultPage extends StatelessWidget {
  final ScanResultPageArgs args;

  const ScanResultPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ScanResultCubit(navigator: ScanResultNavigator(context)),
      child: ScanResultChildPage(args: args),
    );
  }
}

class ScanResultChildPage extends StatefulWidget {
  final ScanResultPageArgs args;
  const ScanResultChildPage({super.key, required this.args});

  @override
  State<ScanResultChildPage> createState() => _ScanResultChildPageState();
}

class _ScanResultChildPageState extends State<ScanResultChildPage> {
  late final ScanResultCubit _cubit;
  final CardSwiperController _swiperController = CardSwiperController();
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanResultCubit>();
    _cubit.init(widget.args.initialDuplicates);
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);
    return BlocConsumer<ScanResultCubit, ScanResultState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      builder: (context, state) {
        return AppScaffold(
          title: _l10n.scanResults,
          actions: [
            Tooltip(
              message: state.selectedPhotoIds.length == state.duplicates.length
                  ? _l10n.clearSelection
                  : _l10n.selectAll,
              child: TextButton(
                onPressed:
                    state.selectedPhotoIds.length == state.duplicates.length
                    ? () => _cubit.clearSelection()
                    : () => _cubit.selectAll(),
                child: Text(
                  state.selectedPhotoIds.length == state.duplicates.length
                      ? _l10n.deselectAll
                      : _l10n.selectAll,
                  style: _theme.textTheme.bodyMedium?.copyWith(
                    color: _theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          body: _buildGroupedGrid(state),
        );
      },
    );
  }

  Widget _buildGroupedGrid(ScanResultState state) {
    final grouped = state.groupedResults;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: 12.paddingAll,
            child: Text(
              _l10n.detectedDuplicateGroups(grouped.length),
              style: _theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: 12.paddingHorizontal,
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final key = grouped.keys.elementAt(index);
                final items = grouped[key]!;
                final allSelected = items.every(
                  (i) => state.selectedPhotoIds.contains(i.id),
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Haptics.vibrate(HapticsType.selection);
                        _cubit.toggleGroupSelection(key, !allSelected);
                      },
                      child: AppTransparentContainer(
                        height: 48,
                        backgroundColor: allSelected
                            ? _theme.colorScheme.primary
                            : null,
                        borderColor: allSelected
                            ? _theme.colorScheme.primaryContainer
                            : _theme.colorScheme.primary.withValues(alpha: 0.2),
                        child: Row(
                          children: [
                            Icon(
                              allSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: allSelected
                                  ? _theme.colorScheme.onPrimary
                                  : _theme.colorScheme.primary,
                              size: 20,
                            ),
                            12.width,
                            Text(
                              _l10n.groupIndex(index + 1, items.length),
                              style: _theme.textTheme.titleSmall?.copyWith(
                                color: allSelected
                                    ? _theme.colorScheme.onPrimary
                                    : _theme.colorScheme.primary,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    8.height,
                    Padding(
                      padding: 8.paddingHorizontal,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ResponsiveValue<int>(
                            context,
                            conditionalValues: [
                              const Condition.equals(name: MOBILE, value: 3),
                              const Condition.largerThan(
                                name: MOBILE,
                                value: 5,
                              ),
                            ],
                            defaultValue: 3,
                          ).value,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, idx) {
                          final photo = items[idx];
                          final isSelected = state.selectedPhotoIds.contains(
                            photo.id,
                          );
                          return ScanResultListItem(
                            photo: photo,
                            isSelected: isSelected,
                            onTap: () {
                              _cubit.togglePhotoSelection(photo.id);
                            },
                            onLongPress: () =>
                                _cubit.navigator.navigateToMediaViewer(photo),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Action Bar
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return BlocBuilder<ScanResultCubit, ScanResultState>(
      buildWhen: (previous, current) =>
          previous.selectedPhotoIds.length != current.selectedPhotoIds.length,
      builder: (context, state) {
        if (state.selectedPhotoIds.isEmpty) {
          return MediaQuery.of(context).viewPadding.bottom.height;
        }
        return AppTransparentContainer(
          border: 28.borderRadiusTop,
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: AppFilledButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () => _cubit.clearSelection(),
                    text: _l10n.clearSelection,
                  ),
                ),
                12.width,
                Expanded(
                  child: AppFilledButton(
                    backgroundColor: _theme.colorScheme.error,
                    onPressed: () => _cubit.showConfirmationDialog(),
                    foregroundColor: Colors.white,
                    text: _l10n.deleteSelected(state.selectedPhotoIds.length),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
