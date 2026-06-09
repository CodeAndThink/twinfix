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
      builder: (context, state) {
        final isLoading =
            state.deleteAccountStatus.isLoading || state.logoutStatus.isLoading;

        return AppScaffold(
          title: l10n.profileSettings,
          isLoading: isLoading,
          body: SafeArea(
            child: Padding(
              padding: 16.paddingAll,
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
                    24.height,
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AppCubit>().signOut();
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: Text(l10n.logout),
                      style: OutlinedButton.styleFrom(
                        padding: 16.paddingAll,
                        shape: RoundedRectangleBorder(
                          borderRadius: 16.borderRadius,
                        ),
                      ),
                    ),
                  ),
                  16.height,
                  SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: l10n.deleteAccount,
                      onPressed: () {
                        ProfileSettingsNavigator(
                          context,
                        ).goToDeleteAccountWarning();
                      },
                      icon: Icons.delete_forever_rounded,
                      backgroundColor: Colors.red,
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
