import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:twinfix/presentation/features/paywall/cubit/paywall_cubit.dart';
import 'package:twinfix/presentation/features/paywall/navigator/paywall_navigator.dart';
import 'package:twinfix/presentation/features/paywall/widgets/benefit_row.dart';
import 'package:twinfix/presentation/features/paywall/widgets/package_card.dart';
import 'package:twinfix/core/extensions/extensions.dart';

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
  late final PaywallNavigator _navigator;
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

    return Scaffold(
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listenWhen: (previous, current) =>
            previous.purchaseStatus != current.purchaseStatus,
        listener: (context, state) {
          if (state.purchaseStatus.isSuccess && state.isPremium) {
            _cubit.navigator.notify.showSuccess(message: _l10n.purchaseSuccess);

            Future.delayed(2.seconds, () {
              if (context.mounted) {
                _navigator.dismiss();
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
                p.identifier == 'premium_1_month' ||
                p.identifier == '\$rc_monthly') {
              monthlyPackage = p;
            } else if (p.packageType == PackageType.lifetime ||
                p.identifier == 'premium_lifetime' ||
                p.identifier == '\$rc_lifetime') {
              lifetimePackage = p;
            }
          }

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 280.0,
                    pinned: true,
                    backgroundColor: Colors.deepPurple,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.deepPurple, Colors.indigo],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          // Decorative circles
                          Positioned(
                            top: -50,
                            right: -50,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.amber,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.stars_rounded,
                                    size: 60,
                                    color: Colors.amber,
                                  ),
                                ),
                                16.height,
                                Text(
                                  _l10n.paywallWelcomeTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => _navigator.dismiss(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _l10n.paywallWelcomeSubtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          24.height,
                          Text(
                            _l10n.featuresTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          16.height,
                          BenefitRow(
                            icon: Icons.check_circle,
                            color: Colors.green,
                            text: _l10n.premiumFeatureNoAds,
                          ),
                          10.height,
                          BenefitRow(
                            icon: Icons.check_circle,
                            color: Colors.green,
                            text: _l10n.premiumFeatureAiTools,
                          ),
                          10.height,
                          BenefitRow(
                            icon: Icons.check_circle,
                            color: Colors.green,
                            text: _l10n.premiumFeatureHighQuality,
                          ),
                          30.height,

                          PackageCard(
                            title: _l10n.packageFreeTitle,
                            price: _l10n.packageFreePrice,
                            description: _l10n.packageFreeDescription,
                            onTap: () => _navigator.safePop(),
                            isPopular: false,
                          ),
                          15.height,

                          PackageCard(
                            title: _l10n.packageMonthlyTitle,
                            price:
                                monthlyPackage?.storeProduct.priceString ??
                                '0.99 USD',
                            description: S
                                .of(context)
                                .packageMonthlyDescription,
                            onTap: () {
                              if (monthlyPackage != null) {
                                _subscriptionCubit.purchase(monthlyPackage);
                              } else {
                                Flushbar(
                                  message: S
                                      .of(context)
                                      .purchaseErrorStoreConnection,
                                  backgroundColor: Colors.orange,
                                  duration: 2.seconds,
                                ).show(context);
                              }
                            },
                            isPopular: false,
                          ),
                          15.height,

                          PackageCard(
                            title: _l10n.packageLifetimeTitle,
                            price:
                                lifetimePackage?.storeProduct.priceString ??
                                '10.99 USD',
                            description: S
                                .of(context)
                                .packageLifetimeDescription,
                            onTap: () {
                              if (lifetimePackage != null) {
                                _subscriptionCubit.purchase(lifetimePackage);
                              } else {
                                Flushbar(
                                  message: S
                                      .of(context)
                                      .purchaseErrorStoreConnection,
                                  backgroundColor: Colors.orange,
                                  duration: 2.seconds,
                                ).show(context);
                              }
                            },
                            isPopular: true,
                          ),

                          20.height,
                          TextButton(
                            onPressed: () {
                              _subscriptionCubit.restore();
                            },
                            child: Text(
                              _l10n.restorePurchases,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          40.height,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (state.purchaseStatus.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
