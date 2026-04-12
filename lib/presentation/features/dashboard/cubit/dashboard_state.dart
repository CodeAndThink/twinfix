part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final LoadStatus status;
  final UserProfile? profile;
  final String? errorMessage;
  final double storageUsagePercent;

  const DashboardState({
    required this.status,
    this.profile,
    this.errorMessage,
    this.storageUsagePercent = 0.0,
  });

  factory DashboardState.initial() =>
      const DashboardState(status: LoadStatus.initial);

  DashboardState copyWith({
    LoadStatus? status,
    UserProfile? profile,
    String? errorMessage,
    double? storageUsagePercent,
  }) {
    return DashboardState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      storageUsagePercent: storageUsagePercent ?? this.storageUsagePercent,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, storageUsagePercent];
}
