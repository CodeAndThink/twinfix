import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_detail/cubit/profile_detail_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import '../../../../core/extensions/extensions.dart';
import '../cubit/profile_detail_cubit.dart';
import '../navigator/profile_detail_navigator.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDetailCubit(
        navigator: ProfileDetailNavigator(context),
        authRepository: locator<AuthRepository>(),
      ),
      child: const _ProfileDetailView(),
    );
  }
}

class _ProfileDetailView extends StatefulWidget {
  const _ProfileDetailView();

  @override
  State<_ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<_ProfileDetailView> {
  late final ProfileDetailCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileDetailCubit>();
    _cubit.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.profile,
      body: SafeArea(
        child: BlocConsumer<ProfileDetailCubit, ProfileDetailState>(
          listener: (context, state) {
            if (state.isLoggedOut) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            if (state.requiresForceLogout) {
              _showForceLogoutDialog(context);
            }
          },
          builder: (context, state) {
            if (state.loadStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: 16.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          padding: 4.padding,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: state.avatarUrl.isNotEmpty
                                ? NetworkImage(state.avatarUrl)
                                : null,
                            child: state.avatarUrl.isEmpty
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                        ),
                        if (state.isPro)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: 4.padding,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(
                    state.name.isNotEmpty ? state.name : _l10n.unknownUser,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  4.height,
                  Text(
                    state.email.isNotEmpty
                        ? state.email
                        : _l10n.noEmailProvided,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  24.height,
                  _buildLevelSection(state: state),
                  24.height,
                  _buildStatsGrid(state: state),
                  24.height,
                  _buildBadgesSection(state: state),
                  32.height,
                  AppFilledButton(
                    onPressed: () => _cubit.logout(),
                    text: _l10n.logout,
                    backgroundColor: _theme.colorScheme.error.withValues(
                      alpha: .2,
                    ),
                    foregroundColor: _theme.colorScheme.error,
                  ),
                  16.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLevelSection({required ProfileDetailState state}) {
    final level = AppUtils.getLevelFromCount(state.totalDeletedPhotos);
    final progress = AppUtils.getLevelProgress(state.totalDeletedPhotos);
    final nextMilestone = AppUtils.getNextMilestone(state.totalDeletedPhotos);

    return Container(
      padding: 16.padding,
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: 16.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _l10n.level(level),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${state.totalDeletedPhotos} / ${nextMilestone.toInt()} ${_l10n.files}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          12.height,
          ClipRRect(
            borderRadius: 8.borderRadius,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.blue.withAlpha(50),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid({required ProfileDetailState state}) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          label: _l10n.cleaned,
          value: AppUtils.formatBytes(state.totalCleanedBytes),
          icon: Icons.cleaning_services,
          color: Colors.green,
        ),
        _buildStatCard(
          label: _l10n.streak,
          value: '${state.streakDays} ${_l10n.days}',
          icon: Icons.local_fire_department,
          color: Colors.orange,
        ),
        _buildStatCard(
          label: _l10n.blurryDeleted,
          value: state.blurryDeletedPhotos.toString(),
          icon: Icons.blur_on,
          color: Colors.blue,
        ),
        _buildStatCard(
          label: _l10n.duplicates,
          value: state.duplicateDeletedPhotos.toString(),
          icon: Icons.copy,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: 12.padding,
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: 16.borderRadius,
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          8.height,
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color.withValues(alpha: .8)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection({required ProfileDetailState state}) {
    if (state.badgeIds.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _l10n.tabDashboard,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        16.height,
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.badgeIds.length,
            itemBuilder: (context, index) {
              return Container(
                margin: 12.paddingRight,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: .1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber.withValues(alpha: .3)),
                ),
                child: Center(
                  child: Tooltip(
                    message: state.badgeIds[index],
                    child: Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showForceLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Unsynced Data Warning'),
          content: const Text(
            'You have unsynced progress. If you log out now, this data will be lost.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(); // Close dialog (Wait for sync)
              },
              child: const Text('Wait for Sync'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _cubit.logout(force: true); // Force logout
              },
              style: TextButton.styleFrom(
                foregroundColor: _theme.colorScheme.error,
              ),
              child: const Text('Force Logout'),
            ),
          ],
        );
      },
    );
  }
}
