import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/services/global_services.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:twinfix/presentation/features/settings/cubit/settings_state.dart';
import 'package:twinfix/presentation/features/settings/navigator/settings_navigator.dart';
import 'package:twinfix/presentation/features/settings/widgets/scan_limit_bottom_sheet.dart';
import 'package:twinfix/presentation/features/settings/widgets/theme_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        navigator: SettingsNavigator(context),
        prefs: locator<SharedPreferences>(),
      ),
      child: const SettingsChildPage(),
    );
  }
}

class SettingsChildPage extends StatefulWidget {
  const SettingsChildPage({super.key});

  @override
  State<SettingsChildPage> createState() => _SettingsChildPageState();
}

class _SettingsChildPageState extends State<SettingsChildPage>
    with SingleTickerProviderStateMixin {
  late final SettingsCubit _cubit;
  late final ThemeCubit _themeCubit;
  late final LocaleCubit _localeCubit;
  late final AppCubit _appCubit;
  late ThemeData _theme;
  late S _l10n;
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _syncAnimationController;

  @override
  void initState() {
    super.initState();
    _themeCubit = locator<ThemeCubit>();
    _localeCubit = locator<LocaleCubit>();
    _appCubit = locator<AppCubit>();
    _cubit = context.read<SettingsCubit>();
    _syncAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

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
    _syncAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.settings,
      actions: [if (_appCubit.state.authStatus.isSuccess) _buildSyncButton()],
      automaticallyImplyLeading: false,
      body: _buildBody(),
    );
  }

  Widget _buildSyncButton() {
    return BlocConsumer<AppCubit, AppState>(
      bloc: _appCubit,
      listenWhen: (previous, current) =>
          previous.syncStatus != current.syncStatus,
      listener: (context, state) {
        if (state.syncStatus.isLoading) {
          _syncAnimationController.repeat();
        } else {
          _syncAnimationController.stop();
        }
      },
      buildWhen: (previous, current) =>
          previous.syncStatus != current.syncStatus,
      builder: (context, state) {
        return IconButton(
          onPressed: state.syncStatus.isLoading
              ? null
              : () => _appCubit.syncLocalData(true),
          icon: RotationTransition(
            turns: _syncAnimationController,
            child: const Icon(Icons.sync),
          ),
          tooltip: 'Sync',
        );
      },
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
          _buildSectionHeader(title: _l10n.premium, color: Colors.amber),
          _buildPremiumSection(),
          _buildSectionHeader(
            title: _l10n.general,
            color: _theme.colorScheme.primary,
          ),
          _buildLanguageTile(),
          12.height,
          _buildScanLimitTile(),
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
          style: _theme.textTheme.titleSmall?.copyWith(
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
                        style: _theme.textTheme.titleMedium?.copyWith(
                          color: _theme.colorScheme.secondary,
                        ),
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
                        onPressed: () => _cubit.navigator.goToLogin(),
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

  Widget _buildScanLimitTile() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final limit = state.maxLimitScanPhoto;
        final displayValue = limit == 0 ? _l10n.scanLimitAll : limit.toString();

        return AppTransparentContainer(
          onTap: () => _showScanLimitPicker(limit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.speed_outlined,
                    color: _theme.colorScheme.secondary,
                  ),
                  8.width,
                  Text(
                    _l10n.scanLimit,
                    style: _theme.textTheme.titleMedium?.copyWith(
                      color: _theme.colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    displayValue,
                    style: _theme.textTheme.titleMedium?.copyWith(
                      color: _theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.width,
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
              if (limit == 0) ...[
                8.height,
                Text(
                  _l10n.scanLimitWarning,
                  style: _theme.textTheme.bodySmall?.copyWith(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showScanLimitPicker(int currentLimit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ScanLimitBottomSheet(
          initialLimit: currentLimit,
          onLimitChanged: (limit) => _cubit.updateScanLimit(limit),
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
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      buildWhen: (previous, current) => previous.isPremium != current.isPremium,
      builder: (context, state) {
        return AppTransparentContainer(
          child: Column(
            children: [
              _buildThemeTile(),
              if (!state.isPremium) ...[
                const Divider(),
                _buildBackgroundTile(),
              ],
            ],
          ),
        );
      },
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
      onTap: () => _cubit.navigator.goToAbout(),
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

  Widget _buildPremiumSection() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final isPremium = state.isPremium;

        return AppTransparentContainer(
          borderColor: isPremium ? Colors.amber : _theme.colorScheme.secondary,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: 8.paddingAll,
                    decoration: BoxDecoration(
                      color: isPremium
                          ? Colors.amber.withValues(alpha: 0.12)
                          : _theme.colorScheme.secondary.withValues(
                              alpha: 0.12,
                            ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.stars_rounded,
                      color: isPremium
                          ? Colors.amber
                          : _theme.colorScheme.secondary,
                      size: 28,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isPremium ? _l10n.premiumPlan : _l10n.freePlan,
                          style: _theme.textTheme.titleMedium?.copyWith(
                            color: isPremium
                                ? Colors.amber
                                : _theme.colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          isPremium
                              ? _l10n.accountSyncActive
                              : _l10n.paywallSubtitle,
                          style: _theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              12.height,
              SizedBox(
                height: 48,
                width: double.infinity,
                child: AppFilledButton(
                  onPressed: () => _cubit.navigator.goToPaywall(),
                  backgroundColor: isPremium
                      ? Colors.amber
                      : _theme.colorScheme.primary,
                  text: (isPremium ? _l10n.premiumPlan : _l10n.upgradeToPremium)
                      .toUpperCase(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
