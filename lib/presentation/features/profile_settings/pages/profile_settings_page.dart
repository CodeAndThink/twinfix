import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_cubit.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_state.dart';
import 'package:twinfix/presentation/features/profile_settings/navigator/profile_settings_navigator.dart';
import 'package:twinfix/presentation/features/profile_settings/widgets/avatar_selection_dialog.dart';
import 'package:twinfix/presentation/features/profile_settings/widgets/frame_selection_dialog.dart';
import 'package:twinfix/presentation/features/profile_settings/pages/profile_settings_loading_page.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_text_field.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import 'package:twinfix/presentation/widgets/user/user_avatar.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSettingsCubit(
        navigator: ProfileSettingsNavigator(context),
        authRepository: locator<AuthRepository>(),
      )..init(),
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

  late ThemeData _theme;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileSettingsCubit>();
  }

  @override
  void dispose() {
    _cubit.nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      builder: (context, state) {
        if (state.loadStatus.isLoading) {
          return const ProfileSettingsLoadingPage();
        }
        return AppScaffold(title: _l10n.profile, body: _buildBody(state));
      },
    );
  }

  Widget _buildBody(ProfileSettingsState state) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarSection(),
          Expanded(
            child: AppTransparentContainer(
              padding: 12.paddingHorizontal,
              child: Column(
                children: [
                  AppTitleHeader(title: _l10n.general),
                  _buildInformationWidgets(),
                  if (!state.isGoogleLogin) ...[
                    AppTitleHeader(title: _l10n.security),
                    _buildSecuritySection(),
                  ],
                  const Spacer(),
                  12.height,
                  SafeArea(child: _buildBottomButton()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      buildWhen: (previous, current) =>
          current.avatarType != previous.avatarType ||
          current.frameType != previous.frameType,
      builder: (context, state) {
        return Padding(
          padding: 12.paddingAll,
          child: Center(
            child: Column(
              children: [
                UserAvatar(
                  avatarType: state.avatarType,
                  frameType: state.frameType,
                  size: 120,
                  onTap: _showAvatarSelection,
                ),
                8.height,
                TextButton(
                  onPressed: _showFrameSelection,
                  child: Text(
                    _l10n.changeFrame,
                    style: TextStyle(color: _theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInformationWidgets() {
    return Column(
      children: [
        AppTextField(
          controller: _cubit.nameController,
          labelText: _l10n.fullName,
          onChanged: _cubit.updateName,
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return GestureDetector(
      onTap: () => _cubit.navigator.goToChangePassword(),
      behavior: HitTestBehavior.opaque,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 48),
        child: Row(
          children: [
            Icon(Icons.lock_outline, color: _theme.colorScheme.secondary),
            12.width,
            Text(_l10n.changePassword, style: _theme.textTheme.titleMedium),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      buildWhen: (previous, current) =>
          current.updateStatus != previous.updateStatus,
      builder: (context, state) {
        return Padding(
          padding: 12.paddingAll,
          child: SizedBox(
            width: double.infinity,
            child: AppFilledButton(
              onPressed: state.updateStatus.isLoading
                  ? null
                  : _cubit.saveProfile,
              text: _l10n.saveProfile,
              isLoading: state.updateStatus.isLoading,
            ),
          ),
        );
      },
    );
  }

  void _showAvatarSelection() {
    showDialog(
      context: context,
      builder: (context) => AvatarSelectionDialog(
        currentAvatarType: _cubit.state.avatarType,
        onAvatarSelected: (avatarType) =>
            _cubit.selectAvatar(avatarType: avatarType),
      ),
    );
  }

  void _showFrameSelection() {
    showDialog(
      context: context,
      builder: (context) => FrameSelectionDialog(
        currentFrameType: _cubit.state.frameType,
        onFrameSelected: (frameType) =>
            _cubit.selectFrame(frameType: frameType),
      ),
    );
  }
}
