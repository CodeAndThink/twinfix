class IapConstants {
  static const String entitlementId = 'premium';

  // Package Identifiers
  static const String monthly = 'premium_1_month';
  static const String lifetime = 'premium_lifetime';

  // Default RevenueCat Identifiers
  static const String rcMonthly = '\$rc_monthly';
  static const String rcLifetime = '\$rc_lifetime';

  static const List<String> monthlyIds = [monthly, rcMonthly];
  static const List<String> lifetimeIds = [lifetime, rcLifetime];
}
