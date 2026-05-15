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
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_text_field.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';

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
  late final TextEditingController _nameController;
  late ThemeData _theme;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileSettingsCubit>();
    _nameController = TextEditingController(text: _cubit.state.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(title: _l10n.profile, body: _buildBody());
  }

  Widget _buildBody() {
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
                  AppTitleHeader(title: _l10n.security),
                  _buildSecuritySection(),
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
          current.avatarUrl != previous.avatarUrl ||
          current.frameUrl != previous.frameUrl,
      builder: (context, state) {
        final frameColor = _getFrameColor(state.frameUrl);
        return Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: _showAvatarSelection,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: frameColor, width: 4),
                      ),
                      child: Padding(
                        padding: 4.paddingAll,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              _theme.colorScheme.surfaceContainerHighest,
                          backgroundImage: state.avatarUrl.isNotEmpty
                              ? (state.avatarUrl.startsWith('assets')
                                    ? AssetImage(state.avatarUrl)
                                    : NetworkImage(state.avatarUrl)
                                          as ImageProvider)
                              : null,
                          child: state.avatarUrl.isEmpty
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: 6.paddingAll,
                        decoration: BoxDecoration(
                          color: _theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
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
        );
      },
    );
  }

  Widget _buildInformationWidgets() {
    return Column(
      children: [
        AppTextField(
          controller: _nameController,
          labelText: _l10n.fullName,
          onChanged: _cubit.updateName,
        ),
        12.height,
        AppTextField(
          controller: _nameController,
          labelText: _l10n.fullName,
          onChanged: _cubit.updateName,
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return ConstrainedBox(
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
        currentAvatarUrl: _cubit.state.avatarUrl,
        onAvatarSelected: _cubit.selectAvatar,
      ),
    );
  }

  void _showFrameSelection() {
    showDialog(
      context: context,
      builder: (context) => FrameSelectionDialog(
        currentFrameUrl: _cubit.state.frameUrl,
        onFrameSelected: _cubit.selectFrame,
      ),
    );
  }

  Color _getFrameColor(String frameId) {
    switch (frameId) {
      case 'gold':
        return Colors.amber;
      case 'silver':
        return Colors.grey;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
