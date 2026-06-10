import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus loadStatus;
  final String? errorMessage;

  const ChangePasswordState({
    this.loadStatus = LoadStatus.initial,
    this.errorMessage,
  });

  ChangePasswordState copyWith({LoadStatus? loadStatus, String? errorMessage}) {
    return ChangePasswordState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMessage];
}
