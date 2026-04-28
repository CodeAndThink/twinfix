import 'package:twinfix/presentation/features/badge_detail/cubit/badge_detail_state.dart';
import 'package:twinfix/presentation/features/badge_detail/navigator/badge_detail_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class BadgeDetailCubit extends BaseCubit<BadgeDetailState> {
  final BadgeDetailNavigator navigator;
  BadgeDetailCubit({required this.navigator}) : super(const BadgeDetailState());
}
