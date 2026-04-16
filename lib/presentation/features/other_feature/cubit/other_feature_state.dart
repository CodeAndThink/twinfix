import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class OtherFeatureState extends Equatable {
  final LoadStatus status;

  const OtherFeatureState({this.status = LoadStatus.initial});

  OtherFeatureState copyWith({LoadStatus? status}) {
    return OtherFeatureState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
