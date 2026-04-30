import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_state.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:twinfix/presentation/features/paywall/navigator/paywall_navigator.dart';
import 'package:twinfix/presentation/features/paywall/widgets/benefit_row.dart';
import 'package:twinfix/presentation/features/paywall/widgets/package_card.dart';
import 'package:twinfix/core/extensions/extensions.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  late final PaywallNavigator _navigator;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _navigator = PaywallNavigator(context);
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return Scaffold(
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state.status == SubscriptionStatus.success && state.isPremium) {
            Flushbar(
              message: _l10n.purchaseSuccess,
              backgroundColor: Colors.green,
              duration: 3.seconds,
            ).show(context);

            Future.delayed(2.seconds, () {
              if (context.mounted) {
                _navigator.safePop();
              }
            });
          } else if (state.status == SubscriptionStatus.error &&
              state.errorMessage != null) {
            Flushbar(
              message: state.errorMessage!,
              backgroundColor: Colors.red,
              duration: 3.seconds,
            ).show(context);
          }
        },
        builder: (context, state) {
          if (state.status == SubscriptionStatus.loading) {
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
                    expandedHeight: 250.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.indigo],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.star,
                            size: 80,
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                      title: Text(
                        _l10n.paywallTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => _navigator.safePop(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: 20.0.padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _l10n.paywallSubtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          30.height,
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
                                context.read<SubscriptionCubit>().purchase(
                                  monthlyPackage,
                                );
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
                                context.read<SubscriptionCubit>().purchase(
                                  lifetimePackage,
                                );
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
                              context.read<SubscriptionCubit>().restore();
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
              if (state.status == SubscriptionStatus.purchasing)
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
