import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';

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
    final primaryColor = const Color(0xFF0F5240); // Darker shade
    final onPrimary = Colors.white;

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
            primaryColor.withValues(alpha: 0.95),
            primaryColor.withValues(alpha: 0.65),
          ],
        ),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/icon.png', width: 60, height: 60),
              Icon(
                Icons.storage_rounded,
                color: onPrimary.withValues(alpha: 0.8),
                size: 32,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${(percent * 100).toInt()}% Used',
                style: TextStyle(
                  color: onPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$usedGB GB / $totalGB GB',
                style: TextStyle(
                  color: onPrimary.withValues(alpha: 0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: percent,
                  backgroundColor: onPrimary.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
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
