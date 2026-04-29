part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus authStatus;
  final LoadStatus syncStatus;
  final String userId;
  final String? email;
  final bool isSyncAllow;
  final UserProfile? userProfile;

  const AppState({
    this.authStatus = LoadStatus.initial,
    this.syncStatus = LoadStatus.initial,
    this.userId = '',
    this.email,
    this.isSyncAllow = false,
    this.userProfile,
  });

  @override
  List<Object?> get props => [
    authStatus,
    syncStatus,
    userId,
    email,
    isSyncAllow,
    userProfile,
  ];

  AppState copyWith({
    LoadStatus? authStatus,
    LoadStatus? syncStatus,
    String? userId,
    String? email,
    bool? isSyncAllow,
    UserProfile? userProfile,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      isSyncAllow: isSyncAllow ?? this.isSyncAllow,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
