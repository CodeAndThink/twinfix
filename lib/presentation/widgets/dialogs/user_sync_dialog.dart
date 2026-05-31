import 'package:flutter/material.dart';
import 'package:twinfix/data/models/sync_strategy.dart';
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
      child: Stack(
        children: [
          Padding(
            padding: 24.paddingAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: 12.paddingAll,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sync_rounded,
                    color: theme.colorScheme.primary,
                    size: 48,
                  ),
                ),
                20.height,
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
                20.height,

                // Option 1: Merge (primary action)
                SizedBox(
                  width: double.maxFinite,
                  child: AppFilledButton(
                    text: l10n.mergeData,
                    icon: Icons.merge_rounded,
                    onPressed: () {
                      Navigator.pop(context);
                      onStrategySelected(SyncStrategy.merge);
                    },
                  ),
                ),
                12.height,

                // Option 2: Keep local data
                SizedBox(
                  width: double.maxFinite,
                  child: AppOutlineButton(
                    text: l10n.keepLocalData,
                    icon: Icons.phone_android_rounded,
                    onPressed: () {
                      Navigator.pop(context);
                      onStrategySelected(SyncStrategy.keepLocal);
                    },
                  ),
                ),
                12.height,

                // Option 3: Restore from cloud
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onStrategySelected(SyncStrategy.keepRemote);
                    },
                    icon: const Icon(Icons.cloud_download_rounded, size: 18),
                    label: Text(
                      l10n.restoreFromCloud,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: 6.paddingAll,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => _showExplanationDialog(context),
              child: Container(
                padding: 6.paddingAll,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.help_outline_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExplanationDialog(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
          backgroundColor: theme.colorScheme.surface,
          child: Padding(
            padding: 24.paddingAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    10.width,
                    Expanded(
                      child: Text(
                        l10n.syncExplainTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                16.height,
                const Divider(height: 1),
                16.height,
                _buildExplanationItem(
                  context,
                  icon: Icons.merge_rounded,
                  iconColor: theme.colorScheme.primary,
                  title: l10n.mergeData,
                  description: l10n.syncExplainMergeDesc,
                ),
                16.height,
                _buildExplanationItem(
                  context,
                  icon: Icons.phone_android_rounded,
                  iconColor: Colors.amber[700] ?? Colors.amber,
                  title: l10n.keepLocalData,
                  description: l10n.syncExplainKeepLocalDesc,
                ),
                16.height,
                _buildExplanationItem(
                  context,
                  icon: Icons.cloud_download_rounded,
                  iconColor: Colors.blue[600] ?? Colors.blue,
                  title: l10n.restoreFromCloud,
                  description: l10n.syncExplainRestoreDesc,
                ),
                24.height,
                SizedBox(
                  width: double.infinity,
                  child: AppFilledButton(
                    text: l10n.done,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExplanationItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: 8.paddingAll,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              4.height,
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
