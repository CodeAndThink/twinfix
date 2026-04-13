import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/features/onboarding/navigator/onboarding_navigator.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
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
      title: _l10n.appName,
      isBack: false,
      body: SafeArea(
        child: Padding(
          padding: AppSizes.s24.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                _l10n.onboardingWelcomeTitle,
                style: _theme.textTheme.headlineMedium?.copyWith(
                  color: _theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              AppSizes.s16.height,
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pets,
                  size: 120,
                  color: _theme.colorScheme.primary,
                ),
              ),
              AppSizes.s24.height,
              Container(
                padding: AppSizes.s16.padding,
                decoration: BoxDecoration(
                  color: _theme.colorScheme.surfaceContainerHighest,
                  borderRadius: AppSizes.borderRadius.borderRadius,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield,
                      color: AppColors.success,
                      size: 32,
                    ),
                    AppSizes.s16.width,
                    Expanded(
                      child: Text(
                        _l10n.onboardingPrivacyMsg,
                        style: _theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              AppSizes.s32.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDemoInstruction(
                    context,
                    title: _l10n.onboardingDemoSwipeLeft,
                    icon: Icons.swipe_left,
                    color: AppColors.discardButton,
                  ),
                  _buildDemoInstruction(
                    context,
                    title: S.of(context).onboardingDemoSwipeRight,
                    icon: Icons.swipe_right,
                    color: AppColors.saveButton,
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _cubit.completeOnboarding(),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text(_l10n.onboardingStartScan)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoInstruction(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 48, color: color),
        AppSizes.s8.height,
        Text(
          title,
          style: _theme.textTheme.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
