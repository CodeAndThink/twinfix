import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

class StorageWidgetUI extends StatelessWidget {
  final double usedSpace;
  final double totalSpace;

  const StorageWidgetUI({
    super.key,
    required this.usedSpace,
    required this.totalSpace,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final percent = totalSpace == 0 ? 0.0 : usedSpace / totalSpace;
    final usedGB = (usedSpace / 1024 / 1024 / 1024).toStringAsFixed(1);
    final totalGB = (totalSpace / 1024 / 1024 / 1024).toStringAsFixed(1);

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.95),
            theme.colorScheme.primary.withValues(alpha: 0.65),
          ],
        ),
        borderRadius: 36.borderRadius,
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
      ),
      padding: 24.paddingAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: 12.borderRadius,
                child: AppAssetImage(
                  path: AppAssets.icon,
                  width: 100,
                  height: 100,
                ),
              ),
              Icon(
                Icons.storage_rounded,
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                size: 32,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).storageUsedPercent((percent * 100).toInt()),
                style: textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              8.height,
              Text(
                '$usedGB GB / $totalGB GB',
                style: textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
              16.height,
              ClipRRect(
                borderRadius: 8.borderRadius,
                child: LinearProgressIndicator(
                  value: percent,
                  backgroundColor: theme.colorScheme.onPrimary.withValues(
                    alpha: 0.2,
                  ),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                  minHeight: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
