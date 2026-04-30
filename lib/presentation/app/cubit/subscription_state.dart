import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum SubscriptionStatus { initial, loading, loaded, purchasing, error, success }

class SubscriptionState extends Equatable {
  final bool isPremium;
  final SubscriptionStatus status;
  final List<Package> packages;
  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.status = SubscriptionStatus.initial,
    this.packages = const [],
    this.errorMessage,
  });

  SubscriptionState copyWith({
    bool? isPremium,
    SubscriptionStatus? status,
    List<Package>? packages,
    String? errorMessage,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      status: status ?? this.status,
      packages: packages ?? this.packages,
      errorMessage:
          errorMessage, // We don't preserve old error messages unless passed explicitly or we want to clear them
    );
  }

  @override
  List<Object?> get props => [isPremium, status, packages, errorMessage];
}
