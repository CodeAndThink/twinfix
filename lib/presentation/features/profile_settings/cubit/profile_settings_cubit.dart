import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_state.dart';
import 'package:twinfix/presentation/features/profile_settings/navigator/profile_settings_navigator.dart';

class ProfileSettingsCubit extends Cubit<ProfileSettingsState> {
  final ProfileSettingsNavigator navigator;
  final AuthRepository authRepository;

  ProfileSettingsCubit({required this.navigator, required this.authRepository})
    : super(const ProfileSettingsState());

  Future<void> init() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final userProfile = await authRepository.getUserProfile();
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          name: userProfile.fullName ?? '',
          email: userProfile.id == 'guest'
              ? ''
              : (userProfile
                    .id), // Ideally we want email here too, but UserProfile doesn't have it.
          avatarUrl: userProfile.avatarUrl ?? '',
          frameUrl: userProfile.frameUrl ?? '',
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

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void selectAvatar(String url) {
    emit(state.copyWith(avatarUrl: url));
  }

  void selectFrame(String url) {
    emit(state.copyWith(frameUrl: url));
  }

  Future<void> saveProfile() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.updateProfile(
        data: {
          'full_name': state.name,
          'avatar_url': state.avatarUrl,
          'frame_url': state.frameUrl,
        },
      );
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.flushBar.showSuccess(
        message: S.current.profileUpdatedSuccessfully,
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
}
