import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_cubit.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
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
  late final S _l10n;
  late final ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileSettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) =>
          previous.deleteAccountStatus != current.deleteAccountStatus ||
          previous.logoutStatus != current.logoutStatus,
      listener: (context, state) {
        if (state.deleteAccountStatus.isLoading ||
            state.logoutStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: AppScaffold(
        title: _l10n.profileSettings,
        actions: [
          Material(
            color: _theme.colorScheme.error,
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
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SafeArea(
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
                          backgroundColor: _theme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          child: Icon(
                            Icons.person_rounded,
                            size: 40,
                            color: _theme.colorScheme.primary,
                          ),
                        ),
                        16.height,
                        Text(state.email!, style: _theme.textTheme.titleMedium),
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
                          text: _l10n.logout,
                          backgroundColor: _theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
