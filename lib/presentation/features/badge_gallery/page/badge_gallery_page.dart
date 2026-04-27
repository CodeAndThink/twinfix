import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/achievement/widgets/badge_list_item.dart';
import 'package:twinfix/presentation/features/achievement_detail/pages/achievement_detail_page.dart';
import 'package:twinfix/presentation/features/badge_gallery/cubit/badge_gallery_cubit.dart';
import 'package:twinfix/presentation/features/badge_gallery/navigator/badge_gallery_navigator.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class BadgeGalleryPageArgs {
  final List<String> ownedBadgeIds;

  const BadgeGalleryPageArgs({required this.ownedBadgeIds});
}

class BadgeGalleryPage extends StatelessWidget {
  final BadgeGalleryPageArgs args;
  const BadgeGalleryPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BadgeGalleryCubit(navigator: BadgeGalleryNavigator(context)),
      child: BadgeGalleryChildPage(args: args),
    );
  }
}

class BadgeGalleryChildPage extends StatelessWidget {
  final BadgeGalleryPageArgs args;
  const BadgeGalleryChildPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final cubit = context.read<BadgeGalleryCubit>();

    // Sort badges: owned ones first
    final List<BadgeItem> sortedBadges = List.from(AppBadges.allBadges);
    sortedBadges.sort((a, b) {
      final aOwned = args.ownedBadgeIds.contains(a.id);
      final bOwned = args.ownedBadgeIds.contains(b.id);
      if (aOwned && !bOwned) return -1;
      if (!aOwned && bOwned) return 1;
      return 0;
    });

    return AppScaffold(
      title: l10n.allBadges,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 75 + 12,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final itemWidth = maxWidth / 4;

            return Wrap(
              runSpacing: 12,
              children: sortedBadges.map((badge) {
                final isOwned = args.ownedBadgeIds.contains(badge.id);
                return SizedBox(
                  width: itemWidth,
                  child: Opacity(
                    opacity: isOwned ? 1.0 : 0.5,
                    child: BadgeListItem(
                      badgeId: badge.id,
                      badge: badge,
                      onTap: () => cubit.navigator.openAchievementDetail(
                        args: AchievementDetailPageArgs(
                          badge: badge,
                          isEarned: isOwned,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
