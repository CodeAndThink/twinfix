import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loadStatus = LoadStatus.initial,
    this.email = '',
    this.password = '',
    this.errorMessage,
  });

  final LoadStatus loadStatus;
  final String email;
  final String password;
  final String? errorMessage;

  LoginState copyWith({
    LoadStatus? loadStatus,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, email, password, errorMessage];
}
