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
import 'package:twinfix/presentation/widgets/loadings/app_loading.dart';
import 'package:twinfix/core/services/iap_service.dart';
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
    _subscriptionCubit.resetOperationStatus();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);
    return BlocConsumer<SubscriptionCubit, SubscriptionState>(
      listenWhen: (previous, current) =>
          previous.purchaseStatus != current.purchaseStatus ||
          previous.restoreStatus != current.restoreStatus ||
          previous.purchaseOutcome != current.purchaseOutcome,
      listener: (context, state) async {
        if ((state.purchaseStatus.isSuccess || state.restoreStatus.isSuccess) &&
            state.isPremium) {
          final warnAboutMonthly =
              state.isMonthlyActive && state.isLifetimeActive;
          await _cubit.navigator.completePurchase(
            warnAboutMonthly: warnAboutMonthly,
          );
        } else if (state.purchaseOutcome == PurchaseOutcome.pending) {
          _cubit.navigator.flushBar.showInfo(
            message: _l10n.purchasePendingMessage,
          );
        } else if (state.purchaseStatus.isFailure) {
          _cubit.navigator.flushBar.showError(
            message: _l10n.purchaseFailureMessage,
          );
        } else if (state.restoreStatus.isFailure) {
          _cubit.navigator.flushBar.showError(
            message: _l10n.restoreFailureMessage,
          );
        }
      },
      builder: (context, state) => PopScope(
        canPop: !state.isBusy,
        child: Stack(
          children: [
            AppScaffold(isShowBackground: false, body: _buildBody()),
            if (state.isBusy) ...[
              const ModalBarrier(dismissible: false, color: Colors.black26),
              const Center(child: AppLoading()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        buildWhen: (previous, current) =>
            previous.initStatus != current.initStatus,
        builder: (context, state) {
          if (state.initStatus.isInitial || state.initStatus.isLoading) {
            return const PaywallLoading();
          }

          return Stack(
            children: [
              Positioned.fill(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildHeader(),
                            _buildDescription(),
                            if (state.initStatus.isFailure) ...[
                              Text(
                                _l10n.purchaseErrorStoreConnection,
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () => _subscriptionCubit.init(),
                                child: Text(_l10n.retryStore),
                              ),
                            ],
                            _buildPackagesCard(),
                            _buildBottomActions(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              borderRadius: 24.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: _theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: 24.borderRadius,
              child: AppAssetImage(path: AppAssets.icon),
            ),
          ),
          24.height,
          Text(
            _l10n.paywallWelcomeTitle,
            textAlign: TextAlign.center,
            style: _theme.textTheme.headlineSmall?.copyWith(
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
        12.height,
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
          icon: Icons.palette_rounded,
          text: _l10n.personalCustomizeableTheme,
        ),
        12.height,
        BenefitRow(
          icon: Icons.cloud_sync_rounded,
          text: _l10n.personalProcessSync,
        ),
      ],
    );
  }

  Widget _buildPackagesCard() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      buildWhen: (previous, current) =>
          previous.packages != current.packages ||
          previous.activeProductIdentifiers !=
              current.activeProductIdentifiers ||
          previous.isReady != current.isReady ||
          previous.isBusy != current.isBusy,
      builder: (context, state) {
        final monthlyPackage = state.monthlyPackage;
        final lifetimePackage = state.lifetimePackage;
        return Column(
          children: [
            12.height,
            PackageCard(
              title: _l10n.packageLifetimeTitle,
              price: lifetimePackage?.storeProduct.priceString ?? '---',
              description: S.of(context).packageLifetimeDescription,
              onTap: () => _cubit.onLifeTimePurchasePress(),
              isPopular: true,
              isDisabled:
                  !state.isReady ||
                  state.isBusy ||
                  lifetimePackage == null ||
                  state.isLifetimeActive,
              overlayText: state.isLifetimeActive ? _l10n.currentPlan : null,
            ),
            12.height,
            PackageCard(
              title: _l10n.packageMonthlyTitle,
              price: monthlyPackage?.storeProduct.priceString ?? '---',
              description: S.of(context).packageMonthlyDescription,
              onTap: () => _cubit.onMonthPurchasePress(),
              isPopular: false,
              isDisabled:
                  !state.isReady ||
                  state.isBusy ||
                  monthlyPackage == null ||
                  state.isMonthlyActive ||
                  state.isLifetimeActive,
              overlayText: state.isLifetimeActive
                  ? _l10n.includedInLifetime
                  : (state.isMonthlyActive ? _l10n.currentPlan : null),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomActions() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      buildWhen: (previous, current) =>
          previous.activeProductIdentifiers !=
              current.activeProductIdentifiers ||
          previous.isReady != current.isReady ||
          previous.isBusy != current.isBusy,
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              if (!state.isLifetimeActive) ...[
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
              ],
              TextButton(
                onPressed: state.isReady && !state.isBusy
                    ? () => _subscriptionCubit.restore()
                    : null,
                child: Text(
                  _l10n.restorePurchases,
                  style: _theme.textTheme.labelLarge?.copyWith(
                    color: _theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
