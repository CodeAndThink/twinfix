import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../generated/l10n.dart';
import '../buttons/app_filled_button.dart';

class UserSyncDialog extends StatelessWidget {
  final VoidCallback onMerge;
  final VoidCallback onDiscard;

  const UserSyncDialog({
    super.key,
    required this.onMerge,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.borderRadius.borderRadius,
      ),
      child: Padding(
        padding: AppSizes.s24.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppSizes.s16.paddingAll,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sync_rounded,
                color: AppColors.primary,
                size: 48,
              ),
            ),
            AppSizes.s24.height,
            Text(
              l10n.syncDataTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizes.s12.height,
            Text(
              l10n.syncDataMessage,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AppSizes.s32.height,
            AppFilledButton(
              text: l10n.mergeData,
              onPressed: () {
                Navigator.pop(context);
                onMerge();
              },
            ),
            AppSizes.s8.height,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDiscard();
              },
              child: Text(
                l10n.startFresh,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
