import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';

class AchievementState extends Equatable {
  final LoadStatus status;
  final UserProfile? profile;
  final String? errorMessage;
  final double storageUsagePercent;
  final List<DeletionHistory> history;

  const AchievementState({
    required this.status,
    this.profile,
    this.errorMessage,
    this.storageUsagePercent = 0.0,
    this.history = const [],
  });

  factory AchievementState.initial() =>
      const AchievementState(status: LoadStatus.initial);

  AchievementState copyWith({
    LoadStatus? status,
    UserProfile? profile,
    String? errorMessage,
    double? storageUsagePercent,
    List<DeletionHistory>? history,
  }) {
    return AchievementState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      storageUsagePercent: storageUsagePercent ?? this.storageUsagePercent,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profile,
    errorMessage,
    storageUsagePercent,
    history,
  ];
}
