import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/widgets/containers/duolingo_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ThemeCubit _themeCubit;
  late final LocaleCubit _localeCubit;
  late ThemeData _theme;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _themeCubit = locator<ThemeCubit>();
    _localeCubit = locator<LocaleCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.settings,
      automaticallyImplyLeading: false,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 75 + 12,
          left: AppSizes.s16,
          right: AppSizes.s16,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMascotHeader(context),
            _buildSectionHeader(
              context,
              _l10n.account,
              color: AppColors.secondary,
            ),
            _buildAccountSection(context),
            AppSizes.s32.height,
            _buildSectionHeader(
              context,
              _l10n.general,
              color: AppColors.primaryBright,
            ),
            DuolingoCard(
              padding: EdgeInsets.zero,
              borderColor: AppColors.primaryBright,
              child: _buildLanguageTile(context),
            ),
            AppSizes.s32.height,
            _buildSectionHeader(
              context,
              _l10n.appearance,
              color: AppColors.primary,
            ),
            DuolingoCard(
              padding: EdgeInsets.zero,
              borderColor: AppColors.primary,
              child: Column(
                children: [
                  _buildThemeTile(context),
                  Divider(
                    height: 1,
                    indent: 56,
                    color: _theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  _buildBackgroundTile(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascotHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
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
              borderRadius: BorderRadius.circular(22),
              child: Image.asset('assets/icon/icon.png', width: 84, height: 84),
            ),
            AppSizes.s16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TwinFix',
                    style: _theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _l10n.settings,
                    style: _theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
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
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    Color? color,
  }) {
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

  Widget _buildAccountSection(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final bool isAuthenticated =
            state is Authenticated || state is NeedSync;
        final String? email = (state is Authenticated)
            ? state.email
            : (state is NeedSync)
            ? state.email
            : null;

        return DuolingoCard(
          borderColor: AppColors.secondary,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
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
              AppSizes.s16.height,
              SizedBox(
                width: double.infinity,
                child: isAuthenticated
                    ? DuolingoButton(
                        onPressed: () => locator<AppCubit>().signOut(),
                        color: _theme.colorScheme.error,
                        child: Text(_l10n.logout.toUpperCase()),
                      )
                    : DuolingoButton(
                        onPressed: () => locator<AppCubit>().login(),
                        color: AppColors.secondary,
                        child: Text(_l10n.login.toUpperCase()),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
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

  Widget _buildThemeTile(BuildContext context) {
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
                  AppSizes.s12.width,
                  _buildThemeOption(
                    context,
                    mode: ThemeMode.dark,
                    icon: Icons.dark_mode_outlined,
                    label: _l10n.themeDark,
                    isSelected: state.themeMode == ThemeMode.dark,
                  ),
                  AppSizes.s12.width,
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
      child: DuolingoButton(
        onPressed: () => _themeCubit.updateTheme(mode: mode),
        color: isSelected ? AppColors.primary : _theme.colorScheme.surface,
        sideColor: isSelected
            ? AppColors.primaryBright
            : _theme.colorScheme.outlineVariant,
        sideHeight: 4,
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF03110D)
                  : _theme.colorScheme.onSurface,
            ),
            AppSizes.s4.height,
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? const Color(0xFF03110D)
                    : _theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundTile(BuildContext context) {
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
              padding: const EdgeInsets.only(bottom: AppSizes.s24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: BackgroundType.values.map((type) {
                    final isSelected = state.backgroundType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => _themeCubit.updateBackground(type: type),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : _theme.colorScheme.outlineVariant,
                                  width: isSelected ? 4 : 2,
                                ),
                                image: type != BackgroundType.none
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
                                color: type == BackgroundType.none
                                    ? _theme.cardColor
                                    : null,
                              ),
                              child: isSelected
                                  ? const Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: AppColors.primary,
                                        size: 32,
                                      ),
                                    )
                                  : null,
                            ),
                            AppSizes.s8.height,
                            Text(
                              type.name,
                              style: _theme.textTheme.labelSmall?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                color: isSelected ? AppColors.primary : null,
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
