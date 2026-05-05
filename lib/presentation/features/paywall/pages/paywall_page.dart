import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';
import 'package:twinfix/presentation/features/paywall/cubit/paywall_cubit.dart';
import 'package:twinfix/presentation/features/paywall/navigator/paywall_navigator.dart';
import 'package:twinfix/presentation/features/paywall/widgets/benefit_row.dart';
import 'package:twinfix/presentation/features/paywall/widgets/package_card.dart';
import 'package:twinfix/presentation/features/paywall/widgets/paywall_loading.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaywallCubit(
        subscriptionCubit: locator.get(),
        navigator: PaywallNavigator(context),
      ),
      child: const PaywallChildPage(),
    );
  }
}

class PaywallChildPage extends StatefulWidget {
  const PaywallChildPage({super.key});

  @override
  State<PaywallChildPage> createState() => _PaywallChildPageState();
}

class _PaywallChildPageState extends State<PaywallChildPage> {
  late final PaywallCubit _cubit;
  late final SubscriptionCubit _subscriptionCubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PaywallCubit>();
    _subscriptionCubit = locator<SubscriptionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(isShowBackground: false, body: _buildBody());
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listenWhen: (previous, current) =>
            previous.purchaseStatus != current.purchaseStatus,
        listener: (context, state) async {
          if (state.purchaseStatus.isSuccess && state.isPremium) {
            await _cubit.navigator.dismiss();
            _cubit.navigator.flushBar.showSuccess(
              message: _l10n.purchaseSuccess,
            );
          } else if (state.purchaseStatus.isFailure &&
              state.errorMessage != null) {
            _cubit.navigator.flushBar.showError(message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.initStatus.isLoading) {
            return const PaywallLoading();
          }

          return Stack(
            children: [
              Positioned(
                top: 16,
                right: 16,
                child: InkWell(
                  onTap: () => _cubit.navigator.dismiss(),
                  child: Container(
                    padding: 8.paddingAll,
                    decoration: BoxDecoration(
                      color: _theme.colorScheme.onSurface.withValues(
                        alpha: 0.05,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: _theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(24, 64, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeader(),
                        _buildDescription(),
                        _buildPackagesCard(state: state),
                        _buildBottomActions(),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.purchaseStatus.isLoading) const AppLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _theme.colorScheme.primary.withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: AppAssetImage(path: AppAssets.icon, width: 64),
            ),
          ),
          24.height,
          Text(
            _l10n.paywallWelcomeTitle,
            textAlign: TextAlign.center,
            style: _theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
          8.height,
          Text(
            _l10n.paywallWelcomeSubtitle,
            textAlign: TextAlign.center,
            style: _theme.textTheme.bodyMedium?.copyWith(
              color: _theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        Text(_l10n.featuresTitle, style: _theme.textTheme.titleMedium),
        20.height,
        BenefitRow(
          icon: Icons.auto_awesome_rounded,
          text: _l10n.premiumFeatureNoAds,
        ),
        12.height,
        BenefitRow(icon: Icons.bolt_rounded, text: _l10n.premiumFeatureAiTools),
        12.height,
        BenefitRow(
          icon: Icons.high_quality_rounded,
          text: _l10n.premiumFeatureHighQuality,
        ),
      ],
    );
  }

  Widget _buildPackagesCard({required SubscriptionState state}) {
    final monthlyPackage = state.monthlyPackage;
    final lifetimePackage = state.lifetimePackage;
    return Column(
      children: [
        PackageCard(
          title: _l10n.packageMonthlyTitle,
          price: monthlyPackage?.storeProduct.priceString ?? '0.99 USD',
          description: S.of(context).packageMonthlyDescription,
          onTap: () => _cubit.onMonthPurchasePress(),
          isPopular: false,
        ),
        16.height,

        PackageCard(
          title: _l10n.packageLifetimeTitle,
          price: lifetimePackage?.storeProduct.priceString ?? '10.99 USD',
          description: S.of(context).packageLifetimeDescription,
          onTap: () => _cubit.onLifeTimePurchasePress(),
          isPopular: true,
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () => _cubit.navigator.dismiss(),
            child: Text(
              _l10n.continueWithFreeVersion,
              style: _theme.textTheme.labelLarge?.copyWith(
                color: _theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          8.height,
          TextButton(
            onPressed: () {
              _subscriptionCubit.restore();
            },
            child: Text(
              _l10n.restorePurchases,
              style: _theme.textTheme.labelLarge?.copyWith(
                color: _theme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
