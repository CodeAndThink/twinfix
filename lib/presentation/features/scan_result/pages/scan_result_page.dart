import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/presentation/features/scan_result/navigator/scan_result_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

import '../../../../core/di/injection.dart';
import '../../../../domain/entities/photo_item.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_result_cubit.dart';
import '../cubit/scan_result_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/extensions.dart';

class ScanResultPageArgs {
  final List<PhotoItem> initialDuplicates;

  const ScanResultPageArgs({required this.initialDuplicates});
}

class ScanResultPage extends StatelessWidget {
  final ScanResultPageArgs args;

  const ScanResultPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanResultCubit(
        userRepository: locator(),
        navigator: ScanResultNavigator(context),
      ),
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
    return AppScaffold(
      title: '',
      appBar: _buildAppBar(),
      body: _buildBody(),
      isLoading: _cubit.state.status.isLoading,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _l10n.scanResults);
  }

  Widget _buildBody() {
    return BlocBuilder<ScanResultCubit, ScanResultState>(
      builder: (context, state) {
        return _buildGroupedGrid(state);
      },
    );
  }

  Widget _buildGroupedGrid(ScanResultState state) {
    final grouped = state.groupedResults;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: AppSizes.s12.paddingHorizontal.copyWith(top: 12),
            child: Text(
              _l10n.detectedDuplicateGroups(grouped.length),
              style: _theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: AppSizes.s12.paddingAll,
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
                      onLongPress: () {
                        Haptics.vibrate(HapticsType.selection);
                        _cubit.toggleGroupSelection(key, !allSelected);
                      },
                      child: AppTransparentContainer(
                        height: 48,
                        color: _theme.colorScheme.primary.withValues(
                          alpha: allSelected ? 1 : 0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              allSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: allSelected
                                  ? _theme.colorScheme.onPrimary
                                  : _theme.colorScheme.onSurface,
                              size: 20,
                            ),
                            AppSizes.s12.width,
                            Text(
                              _l10n.groupIndex(index, items.length),
                              style: _theme.textTheme.titleSmall?.copyWith(
                                color: allSelected
                                    ? _theme.colorScheme.onPrimary
                                    : _theme.colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _l10n.longPressToSelectAll,
                              style: _theme.textTheme.bodySmall?.copyWith(
                                color: allSelected
                                    ? _theme.colorScheme.onPrimary
                                    : _theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSizes.s8.height,
                    Padding(
                      padding: AppSizes.s8.paddingHorizontal,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: items.length,
                        itemBuilder: (context, idx) {
                          final photo = items[idx];
                          final isSelected = state.selectedPhotoIds.contains(
                            photo.id,
                          );
                          return GestureDetector(
                            onTap: () => _cubit.togglePhotoSelection(photo.id),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    _theme.colorScheme.surfaceContainerHighest,
                                borderRadius: 8.borderRadius,
                                border: isSelected
                                    ? Border.all(
                                        color: _theme.colorScheme.primary,
                                        width: 3,
                                      )
                                    : null,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: 8.borderRadius,
                                    child: AppFileImage(path: photo.path),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: _theme.colorScheme.primary,
                                        size: 20,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    AppSizes.s16.height,
                  ],
                );
              },
            ),
          ),

          // Action Bar
          if (state.selectedPhotoIds.isNotEmpty)
            AppTransparentContainer(
              padding: AppSizes.s12.paddingAll,
              borderRadius: 0,
              child: Row(
                children: [
                  Expanded(
                    child: AppFilledButton(
                      backgroundColor: Colors.green,
                      onPressed: () => _cubit.clearSelection(),
                      text: _l10n.clearSelection,
                    ),
                  ),
                  AppSizes.s12.width,
                  Expanded(
                    child: AppFilledButton(
                      backgroundColor: Colors.red,
                      onPressed: () => _showConfirmationDialog(),
                      text: S
                          .of(context)
                          .deleteSelected(state.selectedPhotoIds.length),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_l10n.confirmDelete),
        content: Text(
          S
              .of(context)
              .confirmDeleteMessage(_cubit.state.selectedPhotoIds.length),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(_l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              _l10n.delete,
              style: TextStyle(color: _theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _cubit.confirmDeletion();
    }
  }
}
