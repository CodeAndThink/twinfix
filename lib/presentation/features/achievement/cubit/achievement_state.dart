import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/user_profile.dart';

class AchievementState extends Equatable {
  final LoadStatus status;
  final UserProfile? profile;
  final String? errorMessage;
  final double storageUsagePercent;

  const AchievementState({
    required this.status,
    this.profile,
    this.errorMessage,
    this.storageUsagePercent = 0.0,
  });

  factory AchievementState.initial() =>
      const AchievementState(status: LoadStatus.initial);

  AchievementState copyWith({
    LoadStatus? status,
    UserProfile? profile,
    String? errorMessage,
    double? storageUsagePercent,
  }) {
    return AchievementState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      storageUsagePercent: storageUsagePercent ?? this.storageUsagePercent,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profile,
    errorMessage,
    storageUsagePercent,
  ];
}
