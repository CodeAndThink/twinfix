import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/core/enums/result_view_mode.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/permission_service.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/extensions.dart';
import '../widgets/scan_mode_selector.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<ScanCubit>(),
      child: const ScanChildPage(),
    );
  }
}

class ScanChildPage extends StatefulWidget {
  const ScanChildPage({super.key});

  @override
  State<ScanChildPage> createState() => _ScanChildPageState();
}

class _ScanChildPageState extends State<ScanChildPage> {
  late final ScanCubit _cubit;
  final CardSwiperController _swiperController = CardSwiperController();
  final PermissionService _permissionService = locator<PermissionService>();
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanCubit>();
  }

  Future<void> _checkPermissionAndScan() async {
    final hasPerm = await _permissionService.requestPhotoPermission();
    if (hasPerm) {
      _cubit.startScan();
    } else {
      // Logic handle permission denied
    }
  }

  @override
  void dispose() {
    _cubit.close();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      appBar: AppBar(
        title: Text(_l10n.appName, style: _theme.textTheme.titleLarge),
        centerTitle: true,
        elevation: 0,
        actions: [
          BlocBuilder<ScanCubit, ScanState>(
            builder: (context, state) {
              if (state.status.isSuccess && state.duplicates.isNotEmpty) {
                return IconButton(
                  icon: Icon(
                    state.viewMode.isIndividual
                        ? Icons.grid_view
                        : Icons.view_carousel,
                  ),
                  onPressed: () => _cubit.switchViewMode(
                    state.viewMode.isIndividual
                        ? ResultViewMode.grouped
                        : ResultViewMode.individual,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<ScanCubit, ScanState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            return _buildInitialUI();
          }

          return Column(
            children: [
              // Content Area
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitialUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large Central Button (Pulse Effect)
          GestureDetector(
            onTap: _checkPermissionAndScan,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                border: Border.all(color: _theme.colorScheme.primary, width: 4),
              ),
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.pets,
                    size: 80,
                    color: _theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          AppSizes.s40.height,

          BlocBuilder<ScanCubit, ScanState>(
            buildWhen: (previous, current) =>
                previous.currentMode != current.currentMode,
            builder: (context, state) {
              return ScanModeSelector(
                currentMode: state.currentMode,
                onModeChanged: (mode) => _cubit.switchMode(mode),
                quickScanLabel: _l10n.quickScan,
                deepScanLabel: _l10n.deepScan,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMascot(ScanState state) {
    IconData iconData = Icons.pets;
    Color iconColor = _theme.colorScheme.primary;

    if (state.status.isLoading) {
      iconData = Icons.search;
    } else if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        iconData = Icons.check_circle;
        iconColor = Colors.green;
      } else {
        iconData = Icons.photo_library;
      }
    }

    return Container(
      width: AppSizes.mascotSize,
      height: AppSizes.mascotSize,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 80, color: iconColor),
    );
  }

  Widget _buildContent(ScanState state) {
    if (state.status.isLoading) {
      return Center(
        child: Padding(
          padding: AppSizes.s32.paddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMascot(state),
              AppSizes.s32.height,
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 12,
                  backgroundColor: _theme.colorScheme.primaryContainer
                      .withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _theme.colorScheme.primary,
                  ),
                ),
              ),
              AppSizes.s12.height,
              Text(
                "${(state.progress * 100).toInt()}%",
                style: _theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _theme.colorScheme.primary,
                ),
              ),
              AppSizes.s8.height,
              Text(
                S.of(context).scanningDevice,
                style: _theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        return _buildEmptyUI();
      }

      if (state.viewMode.isGrouped) {
        return _buildGroupedGrid(state);
      }

      return _buildIndividualStack(state);
    }

    if (state.status.isFailure) {
      return Center(
        child: Text(
          S.of(context).error(state.errorMessage ?? ""),
          style: _theme.textTheme.bodyMedium?.copyWith(
            color: _theme.colorScheme.error,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).perfect,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
          AppSizes.s8.height,
          Text(S.of(context).deviceIsClean),
          AppSizes.s32.height,
          ElevatedButton(
            onPressed: () => _cubit.safeEmit(ScanState.initial()),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualStack(ScanState state) {
    final items = state.duplicates;
    return Column(
      children: [
        Padding(
          padding: AppSizes.s16.paddingHorizontal,
          child: Text(
            S.of(context).detectedDuplicates(items.length),
            style: _theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        AppSizes.s16.height,
        Expanded(
          child: CardSwiper(
            controller: _swiperController,
            cardsCount: items.length,
            onSwipe: (previousIndex, currentIndex, direction) {
              Haptics.vibrate(HapticsType.light);
              bool isDiscard = direction == CardSwiperDirection.left;
              _cubit.removePhotoFromList(previousIndex, isDiscard: isDiscard);
              return true;
            },
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
                  final photo = items[index];
                  final isSelected = state.selectedPhotoIds.contains(photo.id);
                  return Container(
                    decoration: BoxDecoration(
                      color: _theme.colorScheme.surface,
                      borderRadius: AppSizes.borderRadius.borderRadius,
                      border: isSelected
                          ? Border.all(
                              color: _theme.colorScheme.error,
                              width: 4,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: _theme.brightness == Brightness.light
                              ? AppColors.cardShadow
                              : Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: AppColors.placeholderText,
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: 4.paddingAll,
                              decoration: BoxDecoration(
                                color: _theme.colorScheme.error,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
          ),
        ),
        AppSizes.s24.height,
        if (state.selectedPhotoIds.isNotEmpty)
          Padding(
            padding: AppSizes.s16.paddingAll,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _theme.colorScheme.error,
                foregroundColor: _theme.colorScheme.onError,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => _showConfirmationDialog(),
              child: Text(
                S.of(context).deleteSelected(state.selectedPhotoIds.length),
              ),
            ),
          )
        else
          Text(
            S.of(context).swipeLeftToDeleteKeepRight,
            style: _theme.textTheme.bodySmall,
          ),
        AppSizes.s32.height,
      ],
    );
  }

  Widget _buildGroupedGrid(ScanState state) {
    final grouped = state.groupedResults;
    return Column(
      children: [
        Padding(
          padding: AppSizes.s16.paddingHorizontal,
          child: Text(
            S.of(context).detectedDuplicateGroups(grouped.length),
            style: _theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: AppSizes.s16.paddingAll,
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _theme.colorScheme.secondaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            allSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: allSelected
                                ? AppColors.primary
                                : AppColors.placeholderText,
                            size: 20,
                          ),
                          AppSizes.s12.width,
                          Text(
                            S.of(context).groupIndex(index, items.length),
                            style: _theme.textTheme.titleSmall,
                          ),
                          const Spacer(),
                          Text(
                            S.of(context).longPressToSelectAll,
                            style: _theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              color: _theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSizes.s8.height,
                  GridView.builder(
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
                            color: _theme.colorScheme.surfaceContainerHighest,
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
                              const Center(
                                child: Icon(
                                  Icons.image,
                                  color: AppColors.placeholderText,
                                ),
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
                  AppSizes.s24.height,
                ],
              );
            },
          ),
        ),

        // Action Bar
        if (state.selectedPhotoIds.isNotEmpty)
          Container(
            padding: AppSizes.s16.paddingAll,
            decoration: BoxDecoration(
              color: _theme.colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _cubit.clearSelection(),
                    child: Text(S.of(context).clearSelection),
                  ),
                ),
                AppSizes.s16.width,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _theme.colorScheme.error,
                      foregroundColor: _theme.colorScheme.onError,
                    ),
                    onPressed: () => _showConfirmationDialog(),
                    child: Text(
                      S
                          .of(context)
                          .deleteSelected(state.selectedPhotoIds.length),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _showConfirmationDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirmDelete),
        content: Text(
          S
              .of(context)
              .confirmDeleteMessage(_cubit.state.selectedPhotoIds.length),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              S.of(context).delete,
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
