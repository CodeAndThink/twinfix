import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    _themeCubit = locator<ThemeCubit>();
    _localeCubit = locator<LocaleCubit>();
    _appCubit = locator<AppCubit>();
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
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 75 + 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroductionWidget(),
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
        ],
      ),
    );
  }

  Widget _buildIntroductionWidget() {
    return Container(
      width: double.infinity,
      padding: 12.paddingAll,
      decoration: BoxDecoration(
        borderRadius: 28.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_theme.colorScheme.primary, _theme.colorScheme.secondary],
        ),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
      ),
      child: SizedBox(
        height: 76,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: 16.borderRadius,
              child: AppAssetImage(path: AppAssets.icon, width: 76, height: 76),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _l10n.settings,
                    style: _theme.textTheme.titleLarge?.copyWith(
                      color: _theme.colorScheme.onPrimary,
                    ),
                  ),
                  4.height,
                  Text(
                    _l10n.settings,
                    style: _theme.textTheme.bodyLarge?.copyWith(
                      color: _theme.colorScheme.primaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _l10n.backgroundStyle,
                    style: _theme.textTheme.bodySmall?.copyWith(
                      color: _theme.colorScheme.surfaceDim,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          color: _theme.colorScheme.secondary,
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
                        backgroundColor: _theme.colorScheme.error,
                        text: _l10n.logout.toUpperCase(),
                      )
                    : AppFilledButton(
                        onPressed: () => _appCubit.login(),
                        backgroundColor: _theme.colorScheme.secondary,
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
          child: Row(
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
              const Spacer(),
              DropdownButton<String>(
                value: state.locale.languageCode,
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down),
                style: _theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value != null) {
                    _localeCubit.changeLanguage(languageCode: value);
                  }
                },
                items: [
                  DropdownMenuItem(value: 'en', child: Text(_l10n.english)),
                  DropdownMenuItem(value: 'vi', child: Text(_l10n.vietnamese)),
                ],
              ),
            ],
          ),
        );
      },
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
                12.width,
                _buildThemeOption(
                  context,
                  mode: ThemeMode.dark,
                  icon: Icons.dark_mode_outlined,
                  label: _l10n.themeDark,
                  isSelected: state.themeMode == ThemeMode.dark,
                ),
                12.width,
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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: BackgroundType.values.map((type) {
                  final isSelected = state.backgroundType == type;
                  return Padding(
                    padding: 12.paddingAll,
                    child: GestureDetector(
                      onTap: () => _themeCubit.updateBackground(type: type),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: 16.borderRadius,
                              border: Border.all(
                                color: isSelected
                                    ? _theme.colorScheme.surface
                                    : _theme.colorScheme.outlineVariant,
                                width: isSelected ? 4 : 2,
                              ),
                              image: !type.isNone
                                  ? DecorationImage(
                                      image: AssetImage(
                                        (_theme.brightness == Brightness.dark
                                                ? type.darkBackgroundPath
                                                : type.lightBackgroundPath) ??
                                            '',
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: type.isNone ? _theme.cardColor : null,
                            ),
                            child: isSelected
                                ? Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: _theme.colorScheme.primary,
                                      size: 32,
                                    ),
                                  )
                                : null,
                          ),
                          8.height,
                          Text(
                            type.name,
                            style: _theme.textTheme.labelSmall?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: isSelected
                                  ? _theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
