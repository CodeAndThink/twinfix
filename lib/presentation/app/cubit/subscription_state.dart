import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/core/constants/iap_constants.dart';
import 'package:twinfix/core/enums/load_status.dart';

class SubscriptionState extends Equatable {
  final bool isPremium;
  final LoadStatus initStatus;
  final LoadStatus purchaseStatus;
  final LoadStatus restoreStatus;
  final List<Package> packages;
  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.initStatus = LoadStatus.initial,
    this.purchaseStatus = LoadStatus.initial,
    this.restoreStatus = LoadStatus.initial,
    this.packages = const [],
    this.errorMessage,
  });

  Package? get monthlyPackage {
    for (var p in packages) {
      if (p.packageType == PackageType.monthly ||
          IapConstants.monthlyIds.contains(p.identifier)) {
        return p;
      }
    }
    return null;
  }

  Package? get lifetimePackage {
    for (var p in packages) {
      if (p.packageType == PackageType.lifetime ||
          IapConstants.lifetimeIds.contains(p.identifier)) {
        return p;
      }
    }
    return null;
  }

  SubscriptionState copyWith({
    bool? isPremium,
    LoadStatus? initStatus,
    LoadStatus? purchaseStatus,
    LoadStatus? restoreStatus,
    List<Package>? packages,
    String? errorMessage,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      initStatus: initStatus ?? this.initStatus,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      restoreStatus: restoreStatus ?? this.restoreStatus,
      packages: packages ?? this.packages,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isPremium,
    initStatus,
    purchaseStatus,
    restoreStatus,
    packages,
    errorMessage,
  ];
}
