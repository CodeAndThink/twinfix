import 'package:equatable/equatable.dart';
import '../../../../presentation/widgets/cubit/base_cubit.dart';

class OtherFeatureState extends Equatable {
  final BaseStatus status;

  const OtherFeatureState({this.status = BaseStatus.initial});

  OtherFeatureState copyWith({BaseStatus? status}) {
    return OtherFeatureState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
