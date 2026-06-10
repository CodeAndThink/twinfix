import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/widgets/images/app_cached_image.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_cubit.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/profile_settings/navigator/profile_settings_navigator.dart';
import 'package:twinfix/domain/enums/auth_provider_type.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';

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
  late S _l10n;
  late ThemeData _theme;

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
        if (state.logoutStatus.isSuccess) {
          _cubit.navigator.safePop();
        }
      },
      child: AppScaffold(
        title: _l10n.profileSettings,
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
                        if (state.avatarUrl != null)
                          AppCachedImage(
                            imageUrl: state.avatarUrl!,
                            width: 80,
                            height: 80,
                            borderRadius: 40,
                          )
                        else
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
                if (state.providers.contains(AuthProviderType.email)) ...[
                  AppTitleHeader(title: _l10n.general),
                  AppTransparentContainer(
                    onTap: () {
                      _cubit.navigator.goToChangePassword();
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: 8.paddingAll,
                          decoration: BoxDecoration(
                            color: _theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.password_rounded,
                            color: _theme.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        16.width,
                        Expanded(
                          child: Text(
                            _l10n.changePassword,
                            style: _theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: _theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ],
                12.height,
                AppTransparentContainer(
                  onTap: () => context.read<AppCubit>().signOut(),
                  backgroundColor: Colors.red,
                  borderColor: Colors.red,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Container(
                        padding: 8.paddingAll,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      16.width,
                      Expanded(
                        child: Text(
                          _l10n.logout,
                          style: _theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
