import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.loadStatus = LoadStatus.initial,
    this.email = '',
    this.errorMessage,
  });

  final LoadStatus loadStatus;
  final String email;
  final String? errorMessage;

  ForgotPasswordState copyWith({
    LoadStatus? loadStatus,
    String? email,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      loadStatus: loadStatus ?? this.loadStatus,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, email, errorMessage];
}
