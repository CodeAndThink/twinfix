import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/presentation/features/onboarding/cubit/onboarding_state.dart';
import 'package:twinfix/presentation/features/onboarding/navigator/onboarding_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class OnboardingCubit extends BaseCubit<OnboardingState> {
  final OnboardingNavigator navigator;

  OnboardingCubit({required this.navigator}) : super(const OnboardingState());

  void next() {
    safeEmit(state.copyWith(page: state.page + 1));
  }

  void previous() {
    safeEmit(state.copyWith(page: state.page - 1));
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    navigator.toScan();
  }
}
