import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/presentation/features/profile_detail/cubit/profile_detail_state.dart';
import 'package:twinfix/presentation/features/profile_detail/navigator/profile_detail_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ProfileDetailCubit extends BaseCubit<ProfileDetailState> {
  final ProfileDetailNavigator navigator;

  ProfileDetailCubit({required this.navigator}) : super(ProfileDetailState());

  Future<void> fetchProfile() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          name: 'John Doe',
          email: 'john.doe@example.com',
          avatarUrl: 'https://i.pravatar.cc/150?img=11',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    // TODO: Call logout usecase
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoggedOut: true));
  }
}
