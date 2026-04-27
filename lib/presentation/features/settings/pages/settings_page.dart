import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/services/global_services.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/features/settings/widgets/theme_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/core/navigation/app_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ThemeCubit _themeCubit;
  late final LocaleCubit _localeCubit;
  late final AppCubit _appCubit;
  late ThemeData _theme;
  late S _l10n;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _themeCubit = locator<ThemeCubit>();
    _localeCubit = locator<LocaleCubit>();
    _appCubit = locator<AppCubit>();

    GlobalServices.instance.settingStream.listen((_) {
      if (_scrollController.hasClients && _scrollController.offset > 0) {
        _scrollController.animateTo(
          0,
          duration: 500.milliseconds,
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.settings,
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 75,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            title: _l10n.account,
            color: _theme.colorScheme.primary,
          ),
          _buildAccountSection(),
          _buildSectionHeader(
            title: _l10n.general,
            color: _theme.colorScheme.primary,
          ),
          _buildLanguageTile(),
          _buildSectionHeader(
            title: _l10n.appearance,
            color: _theme.colorScheme.primary,
          ),
          _buildAppearanceWidget(),
          _buildSectionHeader(
            title: _l10n.more.toUpperCase(),
            color: _theme.colorScheme.primary,
          ),
          _buildMoreSection(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title, Color? color}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: _theme.textTheme.titleMedium?.copyWith(
            color: color ?? _theme.colorScheme.primary,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) =>
          previous.authStatus != current.authStatus ||
          previous.email != current.email,
      builder: (context, state) {
        final bool isAuthenticated = state.authStatus.isSuccess;
        final String? email = state.email;

        return AppTransparentContainer(
          borderColor: _theme.colorScheme.secondary,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: 8.paddingAll,
                    decoration: BoxDecoration(
                      color: _theme.colorScheme.secondary.withValues(
                        alpha: 0.12,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isAuthenticated ? Icons.person : Icons.person_outline,
                      color: _theme.colorScheme.secondary,
                      size: 28,
                    ),
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAuthenticated
                            ? (email ?? _l10n.unknown)
                            : _l10n.notLoggedIn,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        isAuthenticated
                            ? _l10n.accountSyncActive
                            : _l10n.loginToSync,
                        style: _theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              12.height,
              SizedBox(
                height: 48,
                width: double.infinity,
                child: isAuthenticated
                    ? AppFilledButton(
                        onPressed: () => _appCubit.signOut(),
                        backgroundColor: Colors.red,
                        text: _l10n.logout.toUpperCase(),
                      )
                    : AppFilledButton(
                        onPressed: () => _appCubit.login(),
                        backgroundColor: _theme.colorScheme.primary,
                        text: _l10n.login.toUpperCase(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile() {
    return BlocBuilder<LocaleCubit, LocaleState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, state) {
        return AppTransparentContainer(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Row(
                  children: [
                    Icon(Icons.language, color: _theme.colorScheme.secondary),
                    8.width,
                    Text(
                      _l10n.language,
                      style: _theme.textTheme.titleMedium?.copyWith(
                        color: _theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildLanguageOption(
                    context,
                    label: _l10n.english,
                    isSelected: state.locale.languageCode == 'en',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'en'),
                  ),
                  12.width,
                  _buildLanguageOption(
                    context,
                    label: _l10n.vietnamese,
                    isSelected: state.locale.languageCode == 'vi',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'vi'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: AppFilledButton(
        onPressed: onTap,
        backgroundColor: isSelected
            ? _theme.colorScheme.primary
            : _theme.colorScheme.surface,
        foregroundColor: isSelected
            ? _theme.colorScheme.onPrimary
            : _theme.colorScheme.onSurface,
        text: label,
      ),
    );
  }

  Widget _buildAppearanceWidget() {
    return AppTransparentContainer(
      child: Column(
        children: [_buildThemeTile(), const Divider(), _buildBackgroundTile()],
      ),
    );
  }

  Widget _buildThemeTile() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Row(
                children: [
                  Icon(
                    Icons.palette_outlined,
                    color: _theme.colorScheme.secondary,
                  ),
                  8.width,
                  Text(
                    _l10n.theme,
                    style: _theme.textTheme.titleMedium?.copyWith(
                      color: _theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildThemeOption(
                  context,
                  mode: ThemeMode.light,
                  icon: Icons.light_mode_outlined,
                  label: _l10n.themeLight,
                  isSelected: state.themeMode == ThemeMode.light,
                ),
                8.width,
                _buildThemeOption(
                  context,
                  mode: ThemeMode.dark,
                  icon: Icons.dark_mode_outlined,
                  label: _l10n.themeDark,
                  isSelected: state.themeMode == ThemeMode.dark,
                ),
                8.width,
                _buildThemeOption(
                  context,
                  mode: ThemeMode.system,
                  icon: Icons.settings_suggest_outlined,
                  label: _l10n.themeSystem,
                  isSelected: state.themeMode == ThemeMode.system,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required ThemeMode mode,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Expanded(
      child: AppFilledButton(
        onPressed: () {
          _themeCubit.updateTheme(mode: mode);
        },
        backgroundColor: isSelected
            ? _theme.colorScheme.primary
            : _theme.colorScheme.surface,
        foregroundColor: isSelected
            ? _theme.colorScheme.onPrimary
            : _theme.colorScheme.onSurface,
        icon: icon,
        text: label,
      ),
    );
  }

  Widget _buildBackgroundTile() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) =>
          previous.backgroundType != current.backgroundType,
      builder: (context, state) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Row(
                children: [
                  Icon(
                    Icons.wallpaper_outlined,
                    color: _theme.colorScheme.secondary,
                  ),
                  8.width,
                  Text(
                    _l10n.backgroundStyle,
                    style: _theme.textTheme.titleMedium?.copyWith(
                      color: _theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: 12.paddingHorizontal,
                scrollDirection: Axis.horizontal,
                itemCount: BackgroundType.values.length,
                separatorBuilder: (context, index) => 12.width,
                itemBuilder: (context, index) {
                  final type = BackgroundType.values[index];
                  final isSelected = state.backgroundType == type;
                  return ThemeListItem(
                    onTap: () => _themeCubit.updateBackground(type: type),
                    isSelected: isSelected,
                    type: type,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMoreSection() {
    return AppTransparentContainer(
      onTap: () => context.pushNamed(AppRouter.aboutUs),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: _theme.colorScheme.secondary,
            ),
            8.width,
            Text(
              _l10n.aboutUs,
              style: _theme.textTheme.titleMedium?.copyWith(
                color: _theme.colorScheme.secondary,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
