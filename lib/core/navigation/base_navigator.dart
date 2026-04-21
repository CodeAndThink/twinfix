import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/bottom_action_bar/bottom_action_bar_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/category_view/category_view_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/emoji_picker.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/emoji_view/emoji_view_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/search_view/search_view_config.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';
import '../../domain/entities/user_profile.dart';
import '../../presentation/widgets/user/user_level_progress_card.dart';
import '../../generated/l10n.dart';
import '../../domain/entities/badge_item.dart';
import '../../core/enums/sort_type.dart';
import '../../presentation/widgets/dialogs/user_sync_dialog.dart';
import '../../presentation/widgets/buttons/app_filled_button.dart';
import '../../presentation/features/media_viewer/pages/media_viewer_page.dart';
import '../../domain/entities/media_item.dart';
import '../../presentation/features/confirm_delete/page/confirm_delete_page.dart';
import '../../core/navigation/app_router.dart';

abstract class BaseNavigator {
  final BuildContext context;

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

  /// Truy cập vào các loại Dialog của App
  AppDialog get dialog => AppDialog(context);

  /// Truy cập vào các loại thông báo của App
  AppFlushBar get notify => AppFlushBar(context);

  void safePop([Object? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  Future<T?> showAppDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (_) => child,
    );
  }

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
                      l10n.cleanedSpaceSuccess(mediaNum, unit),
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

  Future<void> showNewBadgesDialog(List<String> newBadgeIds) async {
    if (newBadgeIds.isEmpty) return;

    final l10n = S.of(context);
    final theme = Theme.of(context);

    // Màn hình chúc mừng cho badge(s) mới
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
              const SizedBox(height: 16),
              Text(
                l10n.congratsBadgeTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (newBadgeIds.length == 1)
                Text(
                  l10n.congratsBadgeMessage(
                    // Lấy tên thật của mBadge
                    AppBadges.findById(newBadgeIds.first)?.name ??
                        newBadgeIds.first,
                  ),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                )
              else
                Text(
                  l10n.congratsMultipleBadgesMessage(newBadgeIds.length),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 24),
              // Hiển thị danh sách badge icon/names
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: newBadgeIds.map((id) {
                  final badge = AppBadges.findById(id);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shield,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 80,
                          child: Text(
                            badge.name,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.awesome),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showUserSyncDialog({
    required VoidCallback onMerge,
    required VoidCallback onDiscard,
  }) {
    return showAppDialog(
      barrierDismissible: false,
      child: UserSyncDialog(onMerge: onMerge, onDiscard: onDiscard),
    );
  }

  Future<void> showImageEditorSuccessDialog({
    required VoidCallback onFinish,
    required VoidCallback onEditAnother,
  }) {
    final l10n = S.of(context);
    return showAppDialog(
      barrierDismissible: false,
      child: AlertDialog(
        title: Text(l10n.success),
        content: Text(l10n.imageSaved),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onEditAnother();
            },
            child: Text(l10n.editAnotherPhoto),
          ),
          AppFilledButton(
            text: l10n.finish,
            onPressed: () {
              Navigator.pop(context);
              onFinish();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showSortOptionsSheet({
    required SortType selectedValue,
    required void Function(SortType value) onSelected,
  }) {
    return showAppBottomSheet(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: SortType.values.map((sortType) {
            return InkWell(
              onTap: () {
                onSelected(sortType);
                Navigator.pop(context);
              },
              child: Padding(
                padding: 12.paddingAll,
                child: Row(
                  children: [
                    Icon(sortType.icon),
                    8.width,
                    Text(sortType.label),
                    const Spacer(),
                    if (selectedValue == sortType)
                      const Icon(Icons.check_rounded),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<String?> showEmojiDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: AppTransparentContainer(
            height: 350,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                Navigator.pop(context, emoji.emoji);
              },
              config: Config(
                emojiViewConfig: const EmojiViewConfig(
                  columns: 7,
                  emojiSizeMax: 32,
                ),
                categoryViewConfig: const CategoryViewConfig(
                  initCategory: Category.RECENT,
                ),
                bottomActionBarConfig: const BottomActionBarConfig(
                  showBackspaceButton: false,
                  showSearchViewButton: false,
                ),
                searchViewConfig: SearchViewConfig(hintText: S.current.search),
              ),
            ),
          ),
        );
      },
    );
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
