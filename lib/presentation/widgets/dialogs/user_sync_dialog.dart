import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
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
      shape: RoundedRectangleBorder(borderRadius: 12.borderRadius),
      child: Padding(
        padding: 24.paddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: 12.paddingAll,
              decoration: BoxDecoration(
                color: AppColors.seed.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sync_rounded,
                color: AppColors.seed,
                size: 48,
              ),
            ),
            24.height,
            Text(
              l10n.syncDataTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            12.height,
            Text(
              l10n.syncDataMessage,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            32.height,
            AppFilledButton(
              text: l10n.mergeData,
              onPressed: () {
                Navigator.pop(context);
                onMerge();
              },
            ),
            8.height,
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
