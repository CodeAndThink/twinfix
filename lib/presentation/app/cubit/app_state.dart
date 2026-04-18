part of 'app_cubit.dart';

class AppState extends Equatable {
  final LoadStatus authStatus;
  final String userId;
  final String? email;
  final bool isSyncAllow;

  const AppState({
    this.authStatus = LoadStatus.initial,
    this.userId = '',
    this.email,
    this.isSyncAllow = false,
  });

  @override
  List<Object?> get props => [authStatus, userId, email, isSyncAllow];

  AppState copyWith({
    LoadStatus? authStatus,
    String? userId,
    String? email,
    bool? isSyncAllow,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      isSyncAllow: isSyncAllow ?? this.isSyncAllow,
    );
  }
}
