import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class DeleteAccountState extends Equatable {
  final LoadStatus status;

  const DeleteAccountState({this.status = LoadStatus.initial});

  DeleteAccountState copyWith({LoadStatus? status}) {
    return DeleteAccountState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
