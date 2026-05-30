import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ContactState extends Equatable {
  final LoadStatus status;

  const ContactState({this.status = LoadStatus.initial});

  factory ContactState.initial() => const ContactState();

  ContactState copyWith({LoadStatus? status}) {
    return ContactState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
