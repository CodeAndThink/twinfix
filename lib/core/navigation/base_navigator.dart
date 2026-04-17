import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';
import '../../domain/entities/user_profile.dart';
import '../../presentation/widgets/user/user_level_progress_card.dart';
import '../../generated/l10n.dart';
import '../../domain/entities/badge_item.dart';

abstract class BaseNavigator {
  final BuildContext context;

  const BaseNavigator(this.context);

  /// Truy cập vào các loại Dialog của App
  AppDialog get dialog => AppDialog(context);

  /// Truy cập vào các loại thông báo của App
  AppFlushBar get notify => AppFlushBar(context);

  void safePop([Object? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
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
