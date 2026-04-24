import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/generated/l10n.dart';

class HistoryListItem extends StatelessWidget {
  final DeletionHistory history;

  const HistoryListItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);
    final dateStr =
        DateFormat('MMM dd, yyyy • HH:mm').format(history.timestamp);
    final sizeStr = AppUtils.formatBytes(history.bytesFreed);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppTransparentContainer(
        padding: 16.paddingAll,
        child: Row(
          children: [
            Container(
              padding: 10.paddingAll,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cleaning_services_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.deletedItemsCount(history.totalCount),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  4.height,
                  Text(
                    dateStr,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sizeStr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (history.blurryCount > 0 || history.duplicateCount > 0)
                  Text(
                    '${history.blurryCount} blurry • ${history.duplicateCount} dups',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.secondary,
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
