part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus authStatus;
  final LoadStatus loginStatus;
  final LoadStatus logoutStatus;
  final LoadStatus syncStatus;
  final LoadStatus deleteAccountStatus;
  final String userId;
  final String? email;
  final bool isSyncAllow;
  final UserProfile? userProfile;

  const AppState({
    this.authStatus = LoadStatus.initial,
    this.loginStatus = LoadStatus.initial,
    this.logoutStatus = LoadStatus.initial,
    this.syncStatus = LoadStatus.initial,
    this.deleteAccountStatus = LoadStatus.initial,
    this.userId = '',
    this.email,
    this.isSyncAllow = false,
    this.userProfile,
  });

  @override
  List<Object?> get props => [
    authStatus,
    loginStatus,
    logoutStatus,
    syncStatus,
    deleteAccountStatus,
    userId,
    email,
    isSyncAllow,
    userProfile,
  ];

  AppState copyWith({
    LoadStatus? authStatus,
    LoadStatus? loginStatus,
    LoadStatus? logoutStatus,
    LoadStatus? syncStatus,
    LoadStatus? deleteAccountStatus,
    String? userId,
    String? email,
    bool? isSyncAllow,
    UserProfile? userProfile,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      isSyncAllow: isSyncAllow ?? this.isSyncAllow,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
