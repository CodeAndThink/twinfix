import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus loadStatus;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordState({
    this.loadStatus = LoadStatus.initial,
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  ChangePasswordState copyWith({
    LoadStatus? loadStatus,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordState(
      loadStatus: loadStatus ?? this.loadStatus,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    oldPassword,
    newPassword,
    confirmPassword,
  ];
}
