import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/constants/iap_constants.dart';
import 'package:twinfix/core/constants/key_constants.dart';

enum PurchaseOutcome { success, cancelled, pending, failure }

class IapPurchaseResult {
  final PurchaseOutcome outcome;
  final CustomerInfo? customerInfo;
  const IapPurchaseResult(this.outcome, [this.customerInfo]);
}

@lazySingleton
class IapService {
  Future<void>? _initialization;

  Future<void> init() => _initialization ??= _configure();

  Future<void> _configure() async {
    try {
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.warn);
      final keyName = switch (defaultTargetPlatform) {
        TargetPlatform.android => KeyConstants.revenuecatAndroidKey,
        TargetPlatform.iOS => KeyConstants.revenuecatIosKey,
        _ => throw UnsupportedError('In-app purchases require Android or iOS'),
      };
      if (kIsWeb) {
        throw UnsupportedError('In-app purchases are unavailable on web');
      }
      final apiKey = dotenv.env[keyName];
      if (apiKey == null || apiKey.trim().isEmpty) {
        throw StateError('Missing RevenueCat configuration');
      }
      await Purchases.configure(PurchasesConfiguration(apiKey));
    } catch (_) {
      _initialization = null; // A failed setup can be retried.
      rethrow;
    }
  }

  /// Callers must not interpret a failed read as an inactive entitlement.
  Future<CustomerInfo> getCustomerInfo() async {
    await init();
    return Purchases.getCustomerInfo();
  }

  Future<bool> checkPremium() async => hasPremium(await getCustomerInfo());

  static bool hasPremium(CustomerInfo info) =>
      info.entitlements.all[IapConstants.entitlementId]?.isActive == true;

  static List<String> activeProductIdentifiers(CustomerInfo info) => {
    ...info.activeSubscriptions,
    for (final entitlement in info.entitlements.all.values)
      if (entitlement.isActive) entitlement.productIdentifier,
  }.toList();

  Future<List<String>> getActiveProductIdentifiers() async =>
      activeProductIdentifiers(await getCustomerInfo());

  Future<List<Package>> getOfferings() async {
    await init();
    final offerings = await Purchases.getOfferings();
    return offerings.current?.availablePackages ?? [];
  }

  Future<IapPurchaseResult> purchasePackage({required Package package}) async {
    await init();
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return IapPurchaseResult(
        hasPremium(result.customerInfo)
            ? PurchaseOutcome.success
            : PurchaseOutcome.failure,
        result.customerInfo,
      );
    } on PlatformException catch (e) {
      // Some platform/configuration errors use nonnumeric codes.
      final code = int.tryParse(e.code);
      if (code == PurchasesErrorCode.purchaseCancelledError.index) {
        return const IapPurchaseResult(PurchaseOutcome.cancelled);
      }
      if (code == PurchasesErrorCode.paymentPendingError.index) {
        return const IapPurchaseResult(PurchaseOutcome.pending);
      }
      rethrow;
    }
  }

  Future<CustomerInfo> restorePurchases() async {
    await init();
    return Purchases.restorePurchases();
  }

  /// Identity changes are serialized by SubscriptionCubit along with purchases.
  /// Never swallow an identity error and continue with the previous customer's info.
  Future<CustomerInfo> syncUser(String? userId) async {
    await init();
    if (userId != null) {
      if (await Purchases.appUserID != userId) {
        return (await Purchases.logIn(userId)).customerInfo;
      }
    } else if (!await Purchases.isAnonymous) {
      return Purchases.logOut();
    }
    return Purchases.getCustomerInfo();
  }

  void addCustomerInfoListener(CustomerInfoUpdateListener listener) =>
      Purchases.addCustomerInfoUpdateListener(listener);

  void removeCustomerInfoListener(CustomerInfoUpdateListener listener) =>
      Purchases.removeCustomerInfoUpdateListener(listener);
}
