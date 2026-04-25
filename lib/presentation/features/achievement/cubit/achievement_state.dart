import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';

class AchievementState extends Equatable {
  //Loading Status
  final LoadStatus loadProfileStatus;
  final LoadStatus loadStorageStatus;
  final LoadStatus loadHistoryStatus;

  //Data
  final UserProfile? profile;
  final double totalStorage;
  final double freeStorage;
  final double storageUsagePercent;
  final List<DeletionHistory> history;

  //Error Message
  final String? errorMessage;

  const AchievementState({
    this.loadProfileStatus = LoadStatus.initial,
    this.loadStorageStatus = LoadStatus.initial,
    this.loadHistoryStatus = LoadStatus.initial,
    this.profile,
    this.errorMessage,
    this.totalStorage = 0.0,
    this.freeStorage = 0.0,
    this.storageUsagePercent = 0.0,
    this.history = const [],
  });

  @override
  List<Object?> get props => [
    loadProfileStatus,
    loadStorageStatus,
    loadHistoryStatus,
    profile,
    totalStorage,
    freeStorage,
    storageUsagePercent,
    history,
    errorMessage,
  ];

  AchievementState copyWith({
    LoadStatus? loadProfileStatus,
    LoadStatus? loadStorageStatus,
    LoadStatus? loadHistoryStatus,
    UserProfile? profile,
    String? errorMessage,
    double? totalStorage,
    double? freeStorage,
    double? storageUsagePercent,
    List<DeletionHistory>? history,
  }) {
    return AchievementState(
      loadProfileStatus: loadProfileStatus ?? this.loadProfileStatus,
      loadStorageStatus: loadStorageStatus ?? this.loadStorageStatus,
      loadHistoryStatus: loadHistoryStatus ?? this.loadHistoryStatus,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      totalStorage: totalStorage ?? this.totalStorage,
      freeStorage: freeStorage ?? this.freeStorage,
      storageUsagePercent: storageUsagePercent ?? this.storageUsagePercent,
      history: history ?? this.history,
    );
  }
}
