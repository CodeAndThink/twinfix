import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';

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
        padding: AppSizes.s16.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, _l10n.account),
            _buildAccountSection(context),
            AppSizes.s24.height,
            _buildSectionHeader(context, _l10n.general),
            _buildSectionCard(context, children: [_buildLanguageTile(context)]),
            AppSizes.s24.height,
            _buildSectionHeader(context, _l10n.appearance),
            _buildSectionCard(
              context,
              children: [
                _buildThemeTile(context),
                const Divider(height: 1, indent: 56),
                _buildBackgroundTile(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: _theme.textTheme.labelMedium?.copyWith(
          color: _theme.colorScheme.primary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.borderRadius.borderRadius,
        side: BorderSide(
          color: _theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
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

        return _buildSectionCard(
          context,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _theme.colorScheme.primaryContainer,
                child: Icon(
                  isAuthenticated ? Icons.person : Icons.person_outline,
                  color: _theme.colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(
                isAuthenticated
                    ? _l10n.loggedInAs(email ?? 'User')
                    : _l10n.notLoggedIn,
              ),
              subtitle: Text(
                isAuthenticated ? '' : _l10n.loginToSync,
                style: _theme.textTheme.bodySmall,
              ),
              trailing: isAuthenticated
                  ? TextButton(
                      onPressed: () => locator<AppCubit>().signOut(),
                      child: Text(
                        _l10n.logout,
                        style: TextStyle(color: _theme.colorScheme.error),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => locator<AppCubit>().login(),
                      child: Text(S.current.login),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<LocaleCubit, LocaleState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.language),
          title: Text(l10n.language),
          trailing: DropdownButton<String>(
            value: state.locale.languageCode,
            underline: const SizedBox(),
            onChanged: (value) {
              if (value != null) {
                _localeCubit.changeLanguage(languageCode: value);
              }
            },
            items: [
              DropdownMenuItem(value: 'en', child: Text(l10n.english)),
              DropdownMenuItem(value: 'vi', child: Text(l10n.vietnamese)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeTile(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: Text(l10n.theme),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(56, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: const Icon(Icons.light_mode_outlined),
                      label: Text(l10n.themeLight),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: const Icon(Icons.dark_mode_outlined),
                      label: Text(l10n.themeDark),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: const Icon(Icons.settings_suggest_outlined),
                      label: Text(l10n.themeSystem),
                    ),
                  ],
                  selected: {state.themeMode},
                  onSelectionChanged: (value) {
                    _themeCubit.updateTheme(mode: value.first);
                  },
                  showSelectedIcon: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBackgroundTile(BuildContext context) {
    final l10n = S.of(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.wallpaper_outlined),
              title: Text(l10n.backgroundStyle),
            ),
            Padding(
              padding: AppSizes.s16.paddingHorizontal.copyWith(
                bottom: AppSizes.s16,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: BackgroundType.values.map((type) {
                    final isSelected = state.backgroundType == type;
                    return Padding(
                      padding: 12.paddingRight,
                      child: InkWell(
                        onTap: () => _themeCubit.updateBackground(type: type),
                        borderRadius: AppSizes.s8.borderRadius,
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: AppSizes.s8.borderRadius,
                                border: isSelected
                                    ? Border.all(
                                        color: _theme.colorScheme.primary,
                                        width: 3,
                                      )
                                    : Border.all(
                                        color:
                                            _theme.colorScheme.outlineVariant,
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
                                        color: Colors.white,
                                        shadows: [Shadow(blurRadius: 4)],
                                      ),
                                    )
                                  : null,
                            ),
                            AppSizes.s4.height,
                            Text(
                              type.name,
                              style: _theme.textTheme.labelSmall?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : null,
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
