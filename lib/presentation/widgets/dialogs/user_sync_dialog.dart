import 'package:flutter/material.dart';
import 'package:twinfix/data/models/sync_strategy.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/extensions.dart';
import '../../../generated/l10n.dart';
import '../buttons/app_filled_button.dart';
import '../buttons/app_outline_button.dart';

/// Dialog shown when a guest user logs into an existing account.
/// Presents 3 sync strategies: keep local, restore from cloud, or merge.
class UserSyncDialog extends StatelessWidget {
  final void Function(SyncStrategy strategy) onStrategySelected;

  const UserSyncDialog({super.key, required this.onStrategySelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 16.borderRadius),
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

            // Option 1: Merge (primary action)
            AppFilledButton(
              text: l10n.mergeData,
              icon: Icons.merge_rounded,
              onPressed: () {
                Navigator.pop(context);
                onStrategySelected(SyncStrategy.merge);
              },
            ),
            12.height,

            // Option 2: Keep local data
            AppOutlineButton(
              text: l10n.keepLocalData,
              icon: Icons.phone_android_rounded,
              onPressed: () {
                Navigator.pop(context);
                onStrategySelected(SyncStrategy.keepLocal);
              },
            ),
            12.height,

            // Option 3: Restore from cloud
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                onStrategySelected(SyncStrategy.keepRemote);
              },
              icon: const Icon(Icons.cloud_download_rounded, size: 18),
              label: Text(
                l10n.restoreFromCloud,
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
