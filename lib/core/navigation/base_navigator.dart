import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/media_viewer/page/media_viewer_page.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';
import '../../domain/entities/user_profile.dart';
import '../../presentation/widgets/user/user_level_progress_card.dart';
import '../../generated/l10n.dart';
import '../../core/enums/sort_type.dart';
import '../../domain/entities/media_item.dart';
import '../../presentation/features/confirm_delete/page/confirm_delete_page.dart';
import '../../core/navigation/app_router.dart';
import '../../core/extensions/extensions.dart';

abstract class BaseNavigator {
  final BuildContext context;

  /// Access to application dialogs
  AppDialog get dialog => AppDialog(context);

  /// Access to application notifications/alerts
  AppFlushBar get flushBar => AppFlushBar(context);

  const BaseNavigator(this.context);

  /// Navigate to full-screen media viewer
  void navigateToMediaViewer(MediaItem photo) {
    pushNamed(AppRouter.mediaViewer, extra: MediaViewerArgs(asset: photo));
  }

  /// Open confirmation dialog for deleting items
  Future<dynamic> openConfirmDelete(List<MediaItem> itemsToDelete) async {
    return await pushNamed(
      AppRouter.confirmDelete,
      extra: ConfirmDeletePageArgs(itemsToDelete: itemsToDelete),
    );
  }

  void safePop([Object? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  bool isCanPop() => context.canPop();

  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool showDragHandle = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      builder: (_) => child,
    );
  }

  void go(String path, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void goNamed(String name, {Object? extra}) {
    context.goNamed(name, extra: extra);
  }

  void push(String path, {Object? extra}) {
    context.push(path, extra: extra);
  }

  Future<Object?> pushNamed(String name, {Object? extra}) async {
    return await context.pushNamed(name, extra: extra);
  }

  void replace(String path, {Object? extra}) {
    context.replace(path, extra: extra);
  }

  void replaceNamed(String name, {Object? extra}) {
    context.replaceNamed(name, extra: extra);
  }

  Future<void> showCleanupSuccess({
    required int mediaNum,
    required UserProfile profile,
    required int totalSizeDeleted,
  }) async {
    final l10n = S.of(context);
    final String unit;
    if (mediaNum == 1) {
      unit = l10n.file;
    } else {
      unit = l10n.files;
    }
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final l10n = S.of(context);
        final theme = Theme.of(context);
        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: 8.paddingAll,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _RiseUpTransition(
                    delay: Duration.zero,
                    child: Container(
                      padding: 12.paddingHorizontal,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.green,
                        size: 48,
                      ),
                    ),
                  ),
                  _RiseUpTransition(
                    delay: 200.milliseconds,
                    child: Text(
                      l10n.cleanedSpaceSuccess(
                        mediaNum,
                        unit,
                        totalSizeDeleted.formatBytes(),
                      ),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  12.height,
                  _RiseUpTransition(
                    delay: 400.milliseconds,
                    child: UserLevelProgressCard(profile: profile),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showSortOptionsSheet({
    required List<SortType> sortTypes,
    required SortType selectedValue,
    required void Function(SortType value) onSelected,
  }) {
    return showAppBottomSheet(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: sortTypes.map((sortType) {
              return InkWell(
                onTap: () {
                  onSelected(sortType);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: 12.paddingAll,
                  decoration: BoxDecoration(
                    color: selectedValue == sortType
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        sortType.icon,
                        color: selectedValue == sortType ? Colors.white : null,
                      ),
                      8.width,
                      Text(
                        sortType.label,
                        style: TextStyle(
                          color: selectedValue == sortType
                              ? Colors.white
                              : null,
                        ),
                      ),
                      8.width,
                      Icon(
                        sortType.secondIcon,
                        color: selectedValue == sortType ? Colors.white : null,
                      ),
                      const Spacer(),
                      if (selectedValue == sortType)
                        const Icon(Icons.check_rounded, color: Colors.white),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future<bool?> showSaveOptions({
    required bool initialSaveAsCopy,
    required ValueChanged<bool> onOptionSelected,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SaveOptionsBottomSheet(
        initialSaveAsCopy: initialSaveAsCopy,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  Future<void> goToPaywall() async {
    await pushNamed(AppRouter.paywall);
  }
}

class _RiseUpTransition extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _RiseUpTransition({required this.child, required this.delay});

  @override
  State<_RiseUpTransition> createState() => _RiseUpTransitionState();
}

class _RiseUpTransitionState extends State<_RiseUpTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 600.milliseconds);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}

class SaveOptionsBottomSheet extends StatelessWidget {
  final bool initialSaveAsCopy;
  final ValueChanged<bool> onOptionSelected;

  const SaveOptionsBottomSheet({
    super.key,
    required this.initialSaveAsCopy,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
              borderRadius: 2.borderRadius,
            ),
          ),
          24.height,
          Text(l10n.save, style: theme.textTheme.titleLarge),
          24.height,
          _OptionItem(
            title: l10n.createNewImage,
            subtitle: l10n.gpsRemovedSuccess,
            isSelected: initialSaveAsCopy,
            onTap: () {
              onOptionSelected(true);
              Navigator.pop(context, true);
            },
          ),
          12.height,
          _OptionItem(
            title: l10n.replaceOriginal,
            subtitle: l10n.delete_confirm_message.split('\n').first,
            isSelected: !initialSaveAsCopy,
            onTap: () {
              onOptionSelected(false);
              Navigator.pop(context, true);
            },
          ),
          24.height,
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionItem({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: 12.borderRadius,
      child: Container(
        padding: 16.paddingAll,
        decoration: BoxDecoration(
          borderRadius: 12.borderRadius,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.1)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isSelected ? theme.colorScheme.primary : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  4.height,
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
