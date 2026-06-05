import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/remove_gps/widgets/remove_gps_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../cubit/remove_gps_cubit.dart';
import '../cubit/remove_gps_state.dart';
import '../navigator/remove_gps_navigator.dart';
import 'remove_gps_loading_page.dart';

class RemoveGPSPage extends StatelessWidget {
  const RemoveGPSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RemoveGPSCubit(locator(), RemoveGPSNavigator(context)),
      child: const RemoveGPSChildPage(),
    );
  }
}

class RemoveGPSChildPage extends StatefulWidget {
  const RemoveGPSChildPage({super.key});

  @override
  State<RemoveGPSChildPage> createState() => _RemoveGPSChildPageState();
}

class _RemoveGPSChildPageState extends State<RemoveGPSChildPage> {
  late final RemoveGPSCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RemoveGPSCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(400.milliseconds);
      if (mounted) {
        _cubit.startScan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.removeGPS,
      actions: [
        BlocBuilder<RemoveGPSCubit, RemoveGPSState>(
          buildWhen: (previous, current) =>
              previous.photos != current.photos ||
              previous.selectedIds != current.selectedIds,
          builder: (context, state) {
            if (state.photos.isEmpty) return const SizedBox.shrink();

            final isAllSelected =
                state.photos.isNotEmpty &&
                state.selectedIds.length == state.photos.length;

            return TextButton(
              onPressed: () {
                if (isAllSelected) {
                  _cubit.clearSelection();
                } else {
                  _cubit.selectAll();
                }
              },
              child: Text(
                isAllSelected ? _l10n.deselectAll : _l10n.selectAll,
                style: _theme.textTheme.bodyMedium?.copyWith(
                  color: _theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoveGPSCubit, RemoveGPSState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isLoading && state.photos.isEmpty) {
          return const RemoveGPSLoadingPage();
        }
        if (state.status.isSuccess ||
            (state.status.isLoading && state.photos.isNotEmpty)) {
          if (state.photos.isEmpty) {
            return _buildEmptyUI();
          }
          return _buildResultUI();
        }
        if (state.status.isFailure) {
          return Center(child: Text(state.errorMessage ?? _l10n.unknown));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 52,
            color: _theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          16.height,
          Text(
            _l10n.nothingFound,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: _theme.colorScheme.primary,
            ),
          ),
          8.height,
          Text(_l10n.noPhotosWithGPSFound, style: _theme.textTheme.bodyMedium),
          24.height,
          AppFilledButton(
            text: _l10n.back,
            onPressed: () => _cubit.navigator.safePop(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultUI() {
    return BlocBuilder<RemoveGPSCubit, RemoveGPSState>(
      buildWhen: (previous, current) =>
          previous.selectedIds != current.selectedIds ||
          previous.photos != current.photos,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(
                  12,
                  MediaQuery.of(context).padding.top + 12,
                  12,
                  MediaQuery.of(context).padding.bottom + 12,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveValue<int>(
                    context,
                    conditionalValues: [
                      const Condition.equals(name: MOBILE, value: 3),
                      const Condition.largerThan(name: MOBILE, value: 5),
                    ],
                    defaultValue: 3,
                  ).value,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  final isSelected = state.selectedIds.contains(photo.id);
                  final isSelectionMode = state.selectedIds.isNotEmpty;

                  return RemoveGPSListItem(
                    photo: photo,
                    isSelected: isSelected,
                    onTap: () {
                      if (isSelectionMode) {
                        _cubit.toggleSelection(id: photo.id);
                      } else {
                        _cubit.navigator.navigateToMediaViewer(photo);
                      }
                    },
                    onLongPress: () {
                      if (!isSelectionMode) {
                        _cubit.toggleSelection(id: photo.id);
                      }
                    },
                  );
                },
              ),
            ),
            if (state.selectedIds.isNotEmpty)
              AppTransparentContainer(
                width: double.maxFinite,
                padding: 12.paddingAll,
                child: SafeArea(
                  top: false,
                  child: AppFilledButton(
                    text: '${_l10n.removeGPS} (${state.selectedIds.length})',
                    onPressed: () => _cubit.onRemoveGPSPressed(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
