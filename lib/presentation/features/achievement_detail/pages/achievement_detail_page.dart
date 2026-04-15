import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/domain/entities/badge_item.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement_detail/cubit/achievement_detail_cubit.dart';

import '../../../widgets/scaffold/app_scaffold.dart';

class AchievementDetailPageArgs {
  final BadgeItem badge;
  final bool isEarned;

  const AchievementDetailPageArgs({
    required this.badge,
    required this.isEarned,
  });
}

class AchievementDetailPage extends StatelessWidget {
  final AchievementDetailPageArgs args;
  const AchievementDetailPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AchievementDetailCubit(navigator: AchievementNavigator(context)),
      child: AchievementDetailChildPage(args: args),
    );
  }
}

class AchievementDetailChildPage extends StatefulWidget {
  final AchievementDetailPageArgs args;

  const AchievementDetailChildPage({super.key, required this.args});

  @override
  State<AchievementDetailChildPage> createState() =>
      _AchievementDetailChildPageState();
}

class _AchievementDetailChildPageState
    extends State<AchievementDetailChildPage> {
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(title: _l10n.badges, body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 75 + 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        children: [
          // Badge Badge Visual
          Center(
            child: Hero(
              tag: 'badge_${widget.args.badge.id}',
              child: Opacity(
                opacity: widget.args.isEarned ? 1.0 : 0.4,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: widget.args.isEarned
                        ? [
                            BoxShadow(
                              color: _theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
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
                      color: widget.args.isEarned
                          ? _theme.colorScheme.primary
                          : AppColors.placeholderText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          40.height,

          // Badge Info Card
          Container(
            padding: 24.paddingAll,
            decoration: BoxDecoration(
              color: _theme.colorScheme.surface,
              borderRadius: 12.borderRadius,
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
                  widget.args.badge.name,
                  style: _theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                16.height,
                Text(
                  widget.args.badge.description,
                  style: _theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.placeholderText,
                  ),
                  textAlign: TextAlign.center,
                ),
                32.height,

                // Progress / Status
                Container(
                  padding: 16.paddingAll,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.surfaceContainerHighest,
                    borderRadius: (12 / 2).borderRadius,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.args.isEarned ? Icons.check_circle : Icons.lock,
                        color: widget.args.isEarned
                            ? AppColors.success
                            : AppColors.placeholderText,
                      ),
                      12.width,
                      Expanded(
                        child: Text(
                          widget.args.isEarned ? _l10n.earned : _l10n.notEarned,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: widget.args.isEarned
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
          32.height,

          // Requirements Details
          if (!widget.args.isEarned) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _l10n.howToEarn,
                style: _theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            16.height,
            Text(
              _l10n.howToEarnDescription,
              style: _theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
