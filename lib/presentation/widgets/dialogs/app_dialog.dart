import 'package:flutter/material.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/bottom_action_bar/bottom_action_bar_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/category_view/category_view_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/emoji_picker.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/emoji_view/emoji_view_config.dart';
import 'package:pro_image_editor/plugins/emoji_picker_flutter/src/search_view/search_view_config.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/dialogs/user_sync_dialog.dart';
import '../../../../core/extensions/extensions.dart';
import '../buttons/app_filled_button.dart';
import '../buttons/app_outline_button.dart';

class AppDialog {
  final BuildContext context;

  const AppDialog(this.context);

  Future<T?> showConfirm<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
      ),
    );
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

  Future<T?> showError<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'Close',
        confirmColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<T?> showSuccess<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'OK',
        confirmColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<T?> showInfo<T>({
    required String title,
    required String message,
    String? closeText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => _AppDialogWidget(
        title: title,
        message: message,
        confirmText: closeText ?? 'Got it',
      ),
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
          shape: RoundedRectangleBorder(borderRadius: 24.borderRadius),
          contentPadding: 24.paddingAll,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
              16.height,
              Text(
                l10n.congratsBadgeTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              8.height,
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
              24.height,
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
                        padding: 12.paddingAll,
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
                        4.height,
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
              24.height,
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

class _AppDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final Color? confirmColor;

  const _AppDialogWidget({
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 12.borderRadius),
      child: Padding(
        padding: 24.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            12.height,
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            24.height,
            Row(
              children: [
                if (cancelText != null)
                  Expanded(
                    child: AppOutlineButton(
                      text: cancelText!,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                if (cancelText != null && confirmText != null) 12.width,
                if (confirmText != null)
                  Expanded(
                    child: AppFilledButton(
                      text: confirmText!,
                      backgroundColor: confirmColor,
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm?.call();
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
