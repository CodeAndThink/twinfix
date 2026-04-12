import 'package:flutter/material.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/extensions/extensions.dart';

import '../../../widgets/scaffold/app_scaffold.dart';

class AchievementDetailPage extends StatelessWidget {
  final BadgeItem badge;
  final bool isEarned;

  const AchievementDetailPage({
    super.key,
    required this.badge,
    required this.isEarned,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).badges,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSizes.s24.paddingAll,
        child: Column(
          children: [
            // Badge Badge Visual
            Center(
              child: Hero(
                tag: 'badge_${badge.id}',
                child: Opacity(
                  opacity: isEarned ? 1.0 : 0.4,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      boxShadow: isEarned
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shield,
                        size: 100,
                        color: isEarned
                            ? AppColors.primary
                            : AppColors.placeholderText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppSizes.s40.height,

            // Badge Info Card
            Container(
              padding: AppSizes.s24.paddingAll,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSizes.borderRadius.borderRadius,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    badge.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSizes.s16.height,
                  Text(
                    badge.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.placeholderText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSizes.s32.height,

                  // Progress / Status
                  Container(
                    padding: AppSizes.s16.paddingAll,
                    decoration: BoxDecoration(
                      color: AppColors.placeholderBackground,
                      borderRadius: (AppSizes.borderRadius / 2).borderRadius,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isEarned ? Icons.check_circle : Icons.lock,
                          color: isEarned
                              ? AppColors.success
                              : AppColors.placeholderText,
                        ),
                        AppSizes.s12.width,
                        Expanded(
                          child: Text(
                            isEarned
                                ? "Đã mở khóa vào 12/04/2024" // Placeholder date
                                : "Chưa hoàn thành yêu cầu",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isEarned
                                  ? AppColors.success
                                  : AppColors.placeholderText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSizes.s32.height,

            // Requirements Details
            if (!isEarned) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Làm sao để đạt được?",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppSizes.s16.height,
              Text(
                "Bạn cần thực hiện thêm các bước dọn dẹp hệ thống hoặc mời bạn bè để nhận về huy hiệu danh giá này.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
