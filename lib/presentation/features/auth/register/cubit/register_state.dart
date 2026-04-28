import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class RegisterState extends Equatable {
  const RegisterState({this.loadStatus = LoadStatus.initial});

  final LoadStatus loadStatus;

  RegisterState copyWith({LoadStatus? loadStatus}) {
    return RegisterState(loadStatus: loadStatus ?? this.loadStatus);
  }

  @override
  List<Object?> get props => [loadStatus];
}
