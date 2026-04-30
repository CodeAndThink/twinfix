import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
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
import 'package:twinfix/core/constants/iap_constants.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaywallCubit(navigator: PaywallNavigator(context)),
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
  late S _l10n;
  late final PaywallCubit _cubit;
  late final SubscriptionCubit _subscriptionCubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PaywallCubit>();
    _subscriptionCubit = locator<SubscriptionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      backgroundColor: Colors.white,
      isShowBackground: false,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _cubit.navigator.dismiss(),
      ),
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listenWhen: (previous, current) =>
            previous.purchaseStatus != current.purchaseStatus,
        listener: (context, state) {
          if (state.purchaseStatus.isSuccess && state.isPremium) {
            _cubit.navigator.notify.showSuccess(message: _l10n.purchaseSuccess);

            Future.delayed(2.seconds, () {
              if (context.mounted) {
                _cubit.navigator.dismiss();
              }
            });
          } else if (state.purchaseStatus.isFailure &&
              state.errorMessage != null) {
            _cubit.navigator.notify.showError(message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.initStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          Package? monthlyPackage;
          Package? lifetimePackage;

          for (var p in state.packages) {
            if (p.packageType == PackageType.monthly ||
                IapConstants.monthlyIds.contains(p.identifier)) {
              monthlyPackage = p;
            } else if (p.packageType == PackageType.lifetime ||
                IapConstants.lifetimeIds.contains(p.identifier)) {
              lifetimePackage = p;
            }
          }

          final theme = Theme.of(context);

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(24, 100, 24, 40),
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                theme.colorScheme.primary.withValues(
                                  alpha: 0.15,
                                ),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Center(
                            child: AppAssetImage(
                              path: AppAssets.icon,
                              width: 64,
                            ),
                          ),
                        ),
                        24.height,
                        Text(
                          _l10n.paywallWelcomeTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        8.height,
                        Text(
                          _l10n.paywallWelcomeSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  40.height,
                  Text(
                    _l10n.featuresTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.height,
                  BenefitRow(
                    icon: Icons.auto_awesome_rounded,
                    text: _l10n.premiumFeatureNoAds,
                  ),
                  12.height,
                  BenefitRow(
                    icon: Icons.bolt_rounded,
                    text: _l10n.premiumFeatureAiTools,
                  ),
                  12.height,
                  BenefitRow(
                    icon: Icons.high_quality_rounded,
                    text: _l10n.premiumFeatureHighQuality,
                  ),
                  40.height,

                  PackageCard(
                    title: _l10n.packageMonthlyTitle,
                    price:
                        monthlyPackage?.storeProduct.priceString ?? '0.99 USD',
                    description: S.of(context).packageMonthlyDescription,
                    onTap: () {
                      if (monthlyPackage != null) {
                        _subscriptionCubit.purchase(monthlyPackage);
                      } else {
                        Flushbar(
                          message: S.of(context).purchaseErrorStoreConnection,
                          backgroundColor: Colors.orange,
                          duration: 2.seconds,
                        ).show(context);
                      }
                    },
                    isPopular: false,
                  ),
                  16.height,

                  PackageCard(
                    title: _l10n.packageLifetimeTitle,
                    price:
                        lifetimePackage?.storeProduct.priceString ??
                        '10.99 USD',
                    description: S.of(context).packageLifetimeDescription,
                    onTap: () {
                      if (lifetimePackage != null) {
                        _subscriptionCubit.purchase(lifetimePackage);
                      } else {
                        Flushbar(
                          message: S.of(context).purchaseErrorStoreConnection,
                          backgroundColor: Colors.orange,
                          duration: 2.seconds,
                        ).show(context);
                      }
                    },
                    isPopular: true,
                  ),

                  32.height,
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () => _cubit.navigator.dismiss(),
                          child: Text(
                            _l10n.continueWithFreeVersion,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
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
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (state.purchaseStatus.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
