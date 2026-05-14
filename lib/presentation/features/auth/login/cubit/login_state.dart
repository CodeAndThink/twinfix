import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus loadStatus;
  final String? errorMessage;

  const LoginState({this.loadStatus = LoadStatus.initial, this.errorMessage});

  LoginState copyWith({LoadStatus? loadStatus, String? errorMessage}) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage];
}
