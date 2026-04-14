import 'package:twinfix/presentation/features/other_feature/cubit/other_feature_state.dart';
import 'package:twinfix/presentation/features/other_feature/navigator/other_feature_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class OtherFeatureCubit extends BaseCubit<OtherFeatureState> {
  final OtherFeatureNavigator navigator;

  OtherFeatureCubit({required this.navigator}) : super(OtherFeatureState());
}
