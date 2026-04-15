import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/di/injection.dart';
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
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroductionWidget(),
          _buildSectionHeader(_l10n.account, color: AppColors.secondary),
          _buildAccountSection(),
          12.height,
          _buildSectionHeader(_l10n.general, color: AppColors.primaryBright),
          AppTransparentContainer(
            padding: EdgeInsets.zero,
            color: AppColors.primaryBright,
            child: _buildLanguageTile(),
          ),
          12.height,
          _buildSectionHeader(_l10n.appearance, color: AppColors.primary),
          AppTransparentContainer(
            padding: EdgeInsets.zero,
            color: AppColors.primary,
            child: Column(
              children: [
                _buildThemeTile(),
                Divider(
                  height: 1,
                  indent: 56,
                  color: _theme.colorScheme.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
                _buildBackgroundTile(),
              ],
            ),
          ),
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xCC0A1E24), Color(0xCC14353D)],
        ),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: 22.borderRadius,
            child: AppAssetImage(path: AppAssets.icon, width: 84, height: 84),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).appName,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                6.height,
                Text(
                  _l10n.settings,
                  style: _theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                6.height,
                Text(
                  _l10n.backgroundStyle,
                  style: _theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: _theme.textTheme.titleMedium?.copyWith(
          color: color ?? _theme.colorScheme.primary,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final bool isAuthenticated =
            state is Authenticated || state is NeedSync;
        final String? email = (state is Authenticated)
            ? state.email
            : (state is NeedSync)
            ? state.email
            : null;

        return AppTransparentContainer(
          color: AppColors.secondary,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: 8.paddingAll,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAuthenticated ? Icons.person : Icons.person_outline,
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ),
                title: Text(
                  isAuthenticated ? (email ?? 'User') : _l10n.notLoggedIn,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  isAuthenticated ? "Account Sync Active" : _l10n.loginToSync,
                  style: _theme.textTheme.bodySmall,
                ),
              ),
              12.height,
              SizedBox(
                width: double.infinity,
                child: isAuthenticated
                    ? AppFilledButton(
                        onPressed: () => _appCubit.signOut(),
                        backgroundColor: _theme.colorScheme.error,
                        text: _l10n.logout.toUpperCase(),
                      )
                    : AppFilledButton(
                        onPressed: () => _appCubit.login(),
                        backgroundColor: AppColors.secondary,
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
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.language, color: AppColors.primaryBright),
          title: Text(
            _l10n.language,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: DropdownButton<String>(
            value: state.locale.languageCode,
            underline: const SizedBox(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryBright,
            ),
            style: _theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBright,
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
        );
      },
    );
  }

  Widget _buildThemeTile() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.palette_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                _l10n.theme,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
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
        onPressed: () => _themeCubit.updateTheme(mode: mode),
        backgroundColor: isSelected
            ? AppColors.primary
            : _theme.colorScheme.surface,
        // sideColor: isSelected
        //     ? AppColors.primaryBright
        //     : _theme.colorScheme.outlineVariant,
        // sideHeight: 4,
        icon: icon,
        text: label,
      ),
    );
  }

  Widget _buildBackgroundTile() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.wallpaper_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                _l10n.backgroundStyle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: 24.paddingBottom,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: 16.paddingHorizontal,
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
                                      ? AppColors.primaryBright
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
            ),
          ],
        );
      },
    );
  }
}
