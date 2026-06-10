import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ResetPasswordState extends Equatable {
  final LoadStatus loadStatus;
  final String? errorMessage;

  const ResetPasswordState({
    this.loadStatus = LoadStatus.initial,
    this.errorMessage,
  });

  ResetPasswordState copyWith({LoadStatus? loadStatus, String? errorMessage}) {
    return ResetPasswordState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage];
}
