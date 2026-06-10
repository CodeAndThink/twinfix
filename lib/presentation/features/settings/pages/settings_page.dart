import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/presentation/widgets/images/app_svg_image.dart';
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
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import 'package:twinfix/presentation/widgets/dialogs/user_sync_dialog.dart';

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
      duration: 1.seconds,
    );
    GlobalServices.instance.settingStream.listen((_) {
      if (_scrollController.hasClients && _scrollController.offset > 0) {
        _scrollController.animateTo(
          0,
          duration: 300.milliseconds,
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _syncAnimationController.dispose();
    GlobalServices.instance.disposeSettingStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);
    return BlocListener<AppCubit, AppState>(
      bloc: _appCubit,
      listenWhen: (previous, current) =>
          !previous.authStatus.isSuccess && current.authStatus.isSuccess,
      listener: (context, state) {
        if (state.loginStatus.isLoading ||
            state.logoutStatus.isLoading ||
            state.syncStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
        _showSyncDialog();
      },
      child: AppScaffold(
        title: _l10n.settings,
        actions: [_buildSyncButton()],
        automaticallyImplyLeading: false,
        body: _buildBody(),
      ),
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

        if (state.syncStatus.isSuccess) {
          _cubit.navigator.flushBar.showSuccess(
            message: _l10n.dataSynchronizedSuccessfully,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.syncStatus != current.syncStatus ||
          previous.authStatus != current.authStatus,
      builder: (context, state) {
        final bool isAuthenticated = state.authStatus.isSuccess;
        if (!isAuthenticated) return const SizedBox.shrink();
        return IconButton(
          onPressed: state.syncStatus.isLoading
              ? null
              : () => _showSyncDialog(),
          icon: RotationTransition(
            turns: _syncAnimationController,
            child: const Icon(Icons.sync),
          ),
          tooltip: 'Sync',
        );
      },
    );
  }

  Future<void> _showSyncDialog() async {
    await _cubit.navigator.dialog.showAppDialog(
      child: UserSyncDialog(
        onStrategySelected: (strategy) => _appCubit.syncLocalData(strategy),
      ),
    );
    GlobalServices.instance.refreshAchievement();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccountSection(),
          AppTransparentContainer(
            padding: 12.paddingHorizontal,
            border: 28.borderRadiusTop,
            child: Column(
              children: [
                AppTitleHeader(title: _l10n.premium, color: Colors.amber),
                _buildPremiumSection(),
                AppTitleHeader(title: _l10n.general),
                _buildLanguageTile(),
                12.height,
                _buildScanLimitTile(),
                12.height,
                _buildHomeWidgetSuggestion(),
                AppTitleHeader(title: _l10n.appearance),
                _buildAppearanceWidget(),
                AppTitleHeader(title: _l10n.more.toUpperCase()),
                _buildMoreSection(),
                (MediaQuery.of(context).padding.bottom + 12).height,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Padding(
      padding: 12.paddingAll,
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.authStatus != current.authStatus ||
            previous.email != current.email ||
            previous.userProfile != current.userProfile,
        builder: (context, state) {
          final bool isAuthenticated = state.authStatus.isSuccess;
          final String? email = state.email;
          final Color accountColor = _theme.colorScheme.primary;
          if (isAuthenticated) {
            return AppTransparentContainer(
              padding: 16.paddingAll,
              onTap: _cubit.navigator.goToProfileSettings,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: _theme.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      size: 24,
                      color: _theme.colorScheme.primary,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email ?? _l10n.unknown,
                          style: _theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        4.height,
                        Text(
                          _l10n.accountSyncActive,
                          style: _theme.textTheme.bodySmall?.copyWith(
                            color: _theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                ],
              ),
            );
          }
          return AppTransparentContainer(
            height: 140,
            padding: 12.paddingAll,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _l10n.notLoggedIn,
                        style: _theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _l10n.loginToSync,
                        style: _theme.textTheme.bodySmall?.copyWith(
                          color: _theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                12.height,
                Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      onPressed: () => _cubit.navigator.goToLogin(),
                      backgroundColor: accountColor,
                      text: _l10n.login.toUpperCase(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageTile() {
    const languageColor = Colors.teal;
    return BlocBuilder<LocaleCubit, LocaleState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (context, state) {
        return AppTransparentContainer(
          borderColor: languageColor.withValues(alpha: 0.3),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Row(
                  children: [
                    Icon(Icons.language, color: languageColor),
                    12.width,
                    Text(
                      _l10n.language,
                      style: _theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildLanguageOption(
                    flag: AppAssets.icUsaFlag,
                    label: _l10n.english,
                    isSelected: state.locale.languageCode == 'en',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'en'),
                  ),
                  8.width,
                  _buildLanguageOption(
                    flag: AppAssets.icVnFlag,
                    label: _l10n.vietnamese,
                    isSelected: state.locale.languageCode == 'vi',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'vi'),
                  ),
                  8.width,
                  _buildLanguageOption(
                    flag: AppAssets.icChinaFlag,
                    label: _l10n.chinese,
                    isSelected: state.locale.languageCode == 'zh',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'zh'),
                  ),
                  8.width,
                  _buildLanguageOption(
                    flag: AppAssets.icJpFlag,
                    label: _l10n.japanese,
                    isSelected: state.locale.languageCode == 'ja',
                    onTap: () =>
                        _localeCubit.changeLanguage(languageCode: 'ja'),
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
    const scanLimitColor = Colors.green;
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.maxLimitScanPhoto != current.maxLimitScanPhoto,
      builder: (context, state) {
        final limit = state.maxLimitScanPhoto;
        final displayValue = limit == 0 ? _l10n.scanLimitAll : limit.toString();

        return AppTransparentContainer(
          borderColor: scanLimitColor.withValues(alpha: 0.3),
          onTap: () => _showScanLimitPicker(limit),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.speed_outlined, color: scanLimitColor),
                  12.width,
                  Text(_l10n.scanLimit, style: _theme.textTheme.titleMedium),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: scanLimitColor.withValues(alpha: 0.1),
                      borderRadius: 21.borderRadius,
                    ),
                    child: Text(
                      displayValue,
                      style: _theme.textTheme.titleMedium?.copyWith(
                        color: scanLimitColor,
                      ),
                    ),
                  ),
                  8.width,
                  const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                ],
              ),
              if (limit == 0) ...[
                8.height,
                Text(
                  _l10n.scanLimitWarning,
                  style: _theme.textTheme.bodySmall?.copyWith(
                    color: _theme.colorScheme.error,
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

  Widget _buildHomeWidgetSuggestion() {
    const widgetColor = Colors.blue;
    return AppTransparentContainer(
      borderColor: widgetColor.withValues(alpha: 0.3),
      onTap: _cubit.navigator.dialog.showHomeWidgetInstructions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.widgets_outlined, color: widgetColor),
              12.width,
              Expanded(
                child: Text(
                  _l10n.homeWidgetSuggestionTitle,
                  style: _theme.textTheme.titleMedium,
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.grey),
            ],
          ),
          8.height,
          Text(
            _l10n.homeWidgetSuggestionSubtitle,
            style: _theme.textTheme.bodySmall?.copyWith(
              color: _theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required String flag,
    required String label,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      flex: isSelected ? 3 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: 24.borderRadius,
        child: Container(
          height: 48,
          padding: 8.paddingAll,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      _theme.colorScheme.primary.withValues(alpha: 0.18),
                      _theme.colorScheme.primary.withValues(alpha: 0.12),
                    ],
                  )
                : null,
            borderRadius: 24.borderRadius,
            border: Border.all(
              color: isSelected ? AppColors.glassStroke : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgImage(path: flag, width: 24, height: 24),
              Flexible(
                child: AnimatedSize(
                  duration: 400.milliseconds,
                  curve: Curves.easeOutCirc,
                  child: isSelected
                      ? Padding(
                          padding: 8.paddingLeft,
                          child: Text(
                            label,
                            style: _theme.textTheme.titleSmall?.copyWith(
                              color: _theme.colorScheme.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
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
              if (state.isPremium) ...[const Divider(), _buildBackgroundTile()],
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeTile() {
    const themeColor = Colors.deepPurple;
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Row(
                children: [
                  const Icon(Icons.palette_outlined, color: themeColor),
                  12.width,
                  Text(_l10n.theme, style: _theme.textTheme.titleMedium),
                ],
              ),
            ),
            Row(
              children: [
                _buildThemeOption(
                  mode: ThemeMode.light,
                  icon: Icons.light_mode_outlined,
                  label: _l10n.themeLight,
                  isSelected: state.themeMode == ThemeMode.light,
                  color: themeColor,
                ),
                8.width,
                _buildThemeOption(
                  mode: ThemeMode.dark,
                  icon: Icons.dark_mode_outlined,
                  label: _l10n.themeDark,
                  isSelected: state.themeMode == ThemeMode.dark,
                  color: themeColor,
                ),
                8.width,
                _buildThemeOption(
                  mode: ThemeMode.system,
                  icon: Icons.settings_suggest_outlined,
                  label: _l10n.themeSystem,
                  isSelected: state.themeMode == ThemeMode.system,
                  color: themeColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption({
    required ThemeMode mode,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color color,
  }) {
    return Expanded(
      child: AppFilledButton(
        onPressed: () {
          _themeCubit.updateTheme(mode: mode);
        },
        backgroundColor: isSelected
            ? color
            : _theme.colorScheme.surface.withValues(alpha: 0.4),
        foregroundColor: isSelected
            ? Colors.white
            : _theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                  12.width,
                  Text(
                    _l10n.backgroundStyle,
                    style: _theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount:
                    BackgroundType.values.where((e) => !e.isCustom).length + 1,
                separatorBuilder: (context, index) => 12.width,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCustomBackgroundPicker();
                  }
                  final type = BackgroundType.values
                      .where((e) => !e.isCustom)
                      .toList()[index - 1];
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

  Widget _buildCustomBackgroundPicker() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) =>
          previous.backgroundType != current.backgroundType ||
          previous.customBackgroundPath != current.customBackgroundPath,
      builder: (context, state) {
        final isSelected = state.backgroundType.isCustom;
        final hasCustomImage =
            state.customBackgroundPath != null &&
            state.customBackgroundPath!.isNotEmpty;

        return ThemeListItem(
          onTap: () {
            if (hasCustomImage && !isSelected) {
              _themeCubit.updateBackground(type: BackgroundType.custom);
            } else {
              _themeCubit.pickCustomBackground();
            }
          },
          isSelected: isSelected,
          type: BackgroundType.custom,
        );
      },
    );
  }

  Widget _buildMoreSection() {
    return AppTransparentContainer(
      onTap: () => _cubit.navigator.goToAbout(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 32),
        child: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: _theme.colorScheme.secondary,
            ),
            8.width,
            Text(_l10n.aboutUs, style: _theme.textTheme.titleMedium),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumSection() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      buildWhen: (previous, current) =>
          previous.initStatus != current.initStatus ||
          previous.refreshStatus != current.refreshStatus ||
          previous.isPremium != current.isPremium,
      builder: (context, state) {
        final isPremium = state.isPremium;
        const premiumGold = Color(0xFFFFD700);
        const premiumOrange = Color(0xFFFF8C00);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPremium
                  ? [
                      premiumGold.withValues(alpha: 0.2),
                      premiumOrange.withValues(alpha: 0.1),
                    ]
                  : [
                      _theme.colorScheme.surface.withValues(alpha: 0.8),
                      _theme.colorScheme.surface.withValues(alpha: 0.6),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: 28.borderRadius,
            border: Border.all(
              color: isPremium
                  ? premiumGold.withValues(alpha: 0.5)
                  : _theme.colorScheme.outlineVariant,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isPremium ? premiumGold : _theme.colorScheme.primary)
                    .withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: state.initStatus.isLoading || state.refreshStatus.isLoading
              ? ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 140),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Padding(
                  padding: 12.paddingAll,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: 10.paddingAll,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [premiumGold, premiumOrange],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: premiumOrange.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.stars_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          16.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isPremium
                                      ? _l10n.premiumPlan
                                      : _l10n.freePlan,
                                  style: _theme.textTheme.titleMedium?.copyWith(
                                    color: isPremium ? premiumOrange : null,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  isPremium
                                      ? _l10n.accountSyncActive
                                      : _l10n.paywallSubtitle,
                                  style: _theme.textTheme.bodySmall?.copyWith(
                                    color: _theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      16.height,
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: 20.borderRadius,
                            border: isPremium
                                ? null
                                : Border.all(color: Colors.amber.shade700),
                          ),
                          child: AppFilledButton(
                            onPressed: () => _cubit.navigator.goToPaywall(),
                            backgroundColor: isPremium
                                ? Colors.amber.shade700
                                : _theme.colorScheme.surface,
                            foregroundColor: isPremium
                                ? Colors.white
                                : Colors.amber,
                            text:
                                (isPremium
                                        ? _l10n.premiumPlan
                                        : _l10n.upgradeToPremium)
                                    .toUpperCase(),
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
