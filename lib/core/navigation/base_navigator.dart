import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import '../../presentation/widgets/notifications/app_flush_bar.dart';
import '../../presentation/widgets/dialogs/app_dialog.dart';
import '../../domain/entities/user_profile.dart';
import '../../presentation/widgets/user/user_level_progress_card.dart';
import '../../generated/l10n.dart';
import '../utils/app_utils.dart';
import '../constants/app_sizes.dart';

abstract class BaseNavigator {
  final BuildContext context;

  const BaseNavigator(this.context);

  /// Truy cập vào các loại Dialog của App
  AppDialog get dialog => AppDialog(context);

  /// Truy cập vào các loại thông báo của App
  AppFlushBar get notify => AppFlushBar(context);

  void safePop() {
    if (context.canPop()) {
      context.pop();
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

  void pushNamed(String name, {Object? extra}) {
    context.pushNamed(name, extra: extra);
  }

  void replace(String path, {Object? extra}) {
    context.replace(path, extra: extra);
  }

  void replaceNamed(String name, {Object? extra}) {
    context.replaceNamed(name, extra: extra);
  }

  void showCleanupSuccess({
    required int bytesSaved,
    required UserProfile profile,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final l10n = S.of(context);
        final theme = Theme.of(context);
        return Padding(
          padding: AppSizes.s24.paddingAll,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: AppSizes.s16.paddingAll,
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
              AppSizes.s16.height,
              Text(
                l10n.cleanedSpaceSuccess(AppUtils.formatBytes(bytesSaved)),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              AppSizes.s24.height,
              UserLevelProgressCard(profile: profile),
              AppSizes.s24.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.perfect),
                ),
              ),
              AppSizes.s32.height,
            ],
          ),
        );
      },
    );
  }
}
