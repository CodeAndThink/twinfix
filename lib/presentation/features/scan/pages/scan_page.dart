import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/permission_service.dart';
import '../../../widgets/scaffold/app_scaffold.dart';
import '../cubit/scan_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/extensions.dart';
import '../navigator/scan_navigator.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanCubit(
        getPhotosUseCase: locator(),
        userRepository: locator(),
        globalAppCubit: locator(),
        navigator: ScanNavigator(context),
      ),
      child: const ScanChildPage(),
    );
  }
}

class ScanChildPage extends StatefulWidget {
  const ScanChildPage({super.key});

  @override
  State<ScanChildPage> createState() => _ScanChildPageState();
}

class _ScanChildPageState extends State<ScanChildPage> {
  late final ScanCubit _cubit;
  final PermissionService _permissionService = locator<PermissionService>();
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ScanCubit>();
  }

  Future<void> _checkPermissionAndScan() async {
    final hasPerm = await _permissionService.requestPhotoPermission();
    if (hasPerm) {
      _cubit.startScan();
    } else {
      // Logic handle permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(
      title: _l10n.appName,
      automaticallyImplyLeading: false,
      body: BlocBuilder<ScanCubit, ScanState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.progress != current.progress ||
            previous.duplicates.length != current.duplicates.length,
        builder: (context, state) {
          if (state.status.isInitial) {
            return _buildInitialUI();
          }

          return Column(
            children: [
              // Content Area
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitialUI() {
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 92,
        20,
        AppSizes.s24,
      ),
      child: Column(
        children: [
          _buildTwinHero(size),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _checkPermissionAndScan,
              icon: const Icon(Icons.auto_awesome),
              label: Text(_l10n.onboardingStartScan),
            ),
          ),
          AppSizes.s12.height,
          SizedBox(
            width: double.infinity,
            child: AppFilledButton(
              onPressed: () => _cubit.navigator.pushMediaTypeSelection(),
              icon: Icons.photo_library_outlined,
              backgroundColor: Colors.white.withValues(alpha: 0.06),
              foregroundColor: Colors.white,
              text: _l10n.galleryManager,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwinHero(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xCC0A1E24), Color(0xCC12343B)],
        ),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 36,
            spreadRadius: -14,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: size.width * 0.66,
            height: size.width * 0.66,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.22),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Image.asset('assets/icon/icon.png', fit: BoxFit.contain),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _l10n.appName,
            style: _theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSizes.s8.height,
          Text(
            _l10n.onboardingWelcomeTitle,
            textAlign: TextAlign.center,
            style: _theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.blur_on_rounded,
                  title: _l10n.tabScan,
                  subtitle: _l10n.scanningDevice,
                ),
              ),
              AppSizes.s12.width,
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.auto_delete_outlined,
                  title: _l10n.galleryManager,
                  subtitle: _l10n.cleanedData,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          AppSizes.s12.height,
          Text(
            title,
            style: _theme.textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          AppSizes.s4.height,
          Text(
            subtitle,
            style: _theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMascot(ScanState state) {
    IconData iconData = Icons.pets;
    Color iconColor = _theme.colorScheme.primary;

    if (state.status.isLoading) {
      iconData = Icons.search;
    } else if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        iconData = Icons.check_circle;
        iconColor = Colors.green;
      } else {
        iconData = Icons.photo_library;
      }
    }

    final double size = MediaQuery.sizeOf(context).width * 0.3;
    final double progressSize = size + 24;

    return Center(
      child: SizedBox(
        width: progressSize,
        height: progressSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (state.status.isLoading) ...[
              // Background track
              SizedBox(
                width: progressSize,
                height: progressSize,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 6,
                  color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                ),
              ),
              // Animated Progress ring
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: state.progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return SizedBox(
                    width: progressSize,
                    height: progressSize,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 10,
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _theme.colorScheme.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
            // Central mascot container
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _theme.colorScheme.surface,
                    AppColors.surfaceAlt.withValues(alpha: 0.92),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.glassStroke, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.16),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(iconData, size: 80, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ScanState state) {
    if (state.status.isLoading) {
      return Center(
        child: Padding(
          padding: AppSizes.s32.paddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMascot(state),
              AppSizes.s40.height,
              Text(
                "${(state.progress * 100).toInt()}%",
                style: _theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _theme.colorScheme.primary,
                ),
              ),
              AppSizes.s8.height,
              Text(
                _l10n.scanningDevice,
                style: _theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.status.isSuccess) {
      if (state.duplicates.isEmpty) {
        return _buildEmptyUI();
      }
      // If we are back here with duplicates (success state), show initial UI
      return _buildInitialUI();
    }

    if (state.status.isFailure) {
      return Center(
        child: Text(
          _l10n.error(state.errorMessage ?? ""),
          style: _theme.textTheme.bodyMedium?.copyWith(
            color: _theme.colorScheme.error,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Container(
        margin: AppSizes.s24.paddingHorizontal,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: AppColors.glassStroke),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_rounded, size: 52, color: AppColors.success),
            AppSizes.s16.height,
            Text(
              _l10n.perfect,
              style: _theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: _theme.colorScheme.primary,
              ),
            ),
            AppSizes.s8.height,
            Text(
              _l10n.deviceIsClean,
              textAlign: TextAlign.center,
              style: _theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSizes.s24.height,
            ElevatedButton(
              onPressed: () => _cubit.reset(),
              child: Text(_l10n.back),
            ),
          ],
        ),
      ),
    );
  }
}
