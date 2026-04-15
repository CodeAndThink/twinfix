import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/presentation/features/onboarding/navigator/onboarding_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/extensions/extensions.dart';
import '../cubit/onboarding_cubit.dart';
import '../../../widgets/scaffold/app_scaffold.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnboardingCubit(navigator: OnboardingNavigator(context)),
      child: const OnboardingChildPage(),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({super.key});

  @override
  State<OnboardingChildPage> createState() => _OnboardingChildPageState();
}

class _OnboardingChildPageState extends State<OnboardingChildPage> {
  late final OnboardingCubit _cubit;
  late ThemeData _theme;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OnboardingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      showAppBar: false,
      body: SafeArea(
        child: Padding(
          padding: 12.paddingAll,
          child: Column(
            children: [
              const Spacer(),
              _buildHeroCard(),
              const Spacer(),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: AppFilledButton(
                  onPressed: () => _cubit.completeOnboarding(),
                  text: _l10n.onboardingStartScan,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: 12.paddingAll,
      decoration: BoxDecoration(
        borderRadius: 36.borderRadius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xCC0B2026), Color(0xCC12313A)],
        ),
        border: Border.all(color: AppColors.glassStroke, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.seed.withValues(alpha: 0.18),
            blurRadius: 40,
            spreadRadius: -12,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.seed.withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              AppAssetImage(
                path: AppAssets.icon,
                width: 190,
                fit: BoxFit.contain,
              ),
            ],
          ),
          16.height,
          Text(
            S.of(context).appName,
            style: _theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          8.height,
          Text(
            _l10n.onboardingWelcomeTitle,
            textAlign: TextAlign.center,
            style: _theme.textTheme.titleMedium?.copyWith(
              color: _theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          20.height,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildPill(icon: Icons.auto_awesome, label: _l10n.tabScan),
              _buildPill(
                icon: Icons.layers_outlined,
                label: _l10n.galleryManager,
              ),
              _buildPill(icon: Icons.verified_outlined, label: _l10n.perfect),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassStroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.seed),
          8.width,
          Text(
            label,
            style: _theme.textTheme.labelLarge?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
