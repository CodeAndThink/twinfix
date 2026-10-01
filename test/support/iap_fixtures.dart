import 'package:purchases_flutter/purchases_flutter.dart';

Map<String, dynamic> customerJson({
  bool premium = true,
  String product = 'lifetime',
  List<String> subscriptions = const ['monthly'],
}) {
  final entitlement = <String, dynamic>{
    'identifier': 'twinfix_premium',
    'isActive': premium,
    'willRenew': product == 'monthly',
    'latestPurchaseDate': '2026-10-01T00:00:00Z',
    'originalPurchaseDate': '2026-09-01T00:00:00Z',
    'productIdentifier': product,
    'isSandbox': true,
    'ownershipType': 'PURCHASED',
    'store': 'PLAY_STORE',
    'periodType': 'NORMAL',
    'expirationDate': null,
    'unsubscribeDetectedAt': null,
    'billingIssueDetectedAt': null,
    'productPlanIdentifier': null,
    'verification': 'NOT_REQUESTED',
  };
  return {
    'entitlements': {
      'all': {'twinfix_premium': entitlement},
      'active': {if (premium) 'twinfix_premium': entitlement},
      'verification': 'NOT_REQUESTED',
    },
    'allPurchaseDates': {product: '2026-10-01T00:00:00Z'},
    'activeSubscriptions': subscriptions,
    'allPurchasedProductIdentifiers': ['monthly', 'lifetime'],
    'nonSubscriptionTransactions': [],
    'firstSeen': '2026-09-01T00:00:00Z',
    'originalAppUserId': 'user-a',
    'allExpirationDates': {},
    'requestDate': '2026-10-01T00:00:00Z',
    'latestExpirationDate': null,
    'originalPurchaseDate': null,
    'originalApplicationVersion': null,
    'managementURL': null,
  };
}

const lifetimePackage = Package(
  r'$rc_lifetime',
  PackageType.lifetime,
  StoreProduct('lifetime', 'Lifetime', 'Lifetime', 10, r'$10', 'USD'),
  PresentedOfferingContext('default', null, null),
);
const monthlyPackage = Package(
  r'$rc_monthly',
  PackageType.monthly,
  StoreProduct('monthly', 'Monthly', 'Monthly', 1, r'$1', 'USD'),
  PresentedOfferingContext('default', null, null),
);
