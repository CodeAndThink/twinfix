import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_cubit.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/profile_settings/navigator/profile_settings_navigator.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileSettingsCubit(navigator: ProfileSettingsNavigator(context)),
      child: const ProfileSettingsChildPage(),
    );
  }
}

class ProfileSettingsChildPage extends StatefulWidget {
  const ProfileSettingsChildPage({super.key});

  @override
  State<ProfileSettingsChildPage> createState() =>
      _ProfileSettingsChildPageState();
}

class _ProfileSettingsChildPageState extends State<ProfileSettingsChildPage> {
  late final ProfileSettingsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileSettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return BlocConsumer<AppCubit, AppState>(
      listenWhen: (previous, current) =>
          previous.deleteAccountStatus != current.deleteAccountStatus ||
          previous.logoutStatus != current.logoutStatus,
      listener: (context, state) {
        // Handle loading overlays if needed, or error messages
      },
      buildWhen: (previous, current) =>
          previous.deleteAccountStatus != current.deleteAccountStatus ||
          previous.logoutStatus != current.logoutStatus,
      builder: (context, state) {
        final isLoading =
            state.deleteAccountStatus.isLoading || state.logoutStatus.isLoading;

        return AppScaffold(
          title: l10n.profileSettings,
          isLoading: isLoading,
          actions: [
            Material(
              color: Colors.red,
              borderRadius: 24.borderRadius,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  _cubit.navigator.goToDeleteAccountWarning();
                },
                child: const SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
          ],
          body: SafeArea(
            child: Padding(
              padding: 12.paddingAll,
              child: Column(
                children: [
                  if (state.email != null) ...[
                    AppTransparentContainer(
                      padding: 24.paddingAll,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person_rounded,
                              size: 40,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          16.height,
                          Text(
                            state.email!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  12.height,
                  Expanded(
                    child: AppTransparentContainer(
                      child: Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: AppFilledButton(
                            onPressed: () {
                              context.read<AppCubit>().signOut();
                              _cubit.navigator.safePop();
                            },
                            icon: Icons.logout_rounded,
                            text: l10n.logout,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
