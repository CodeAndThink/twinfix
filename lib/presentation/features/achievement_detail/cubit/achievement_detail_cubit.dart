import 'package:twinfix/presentation/features/achievement/navigator/achievement_navigator.dart';
import 'package:twinfix/presentation/features/achievement_detail/cubit/achievement_detail_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class AchievementDetailCubit extends BaseCubit<AchievementDetailState> {
  final AchievementNavigator navigator;
  AchievementDetailCubit({required this.navigator})
    : super(const AchievementDetailState());
}
