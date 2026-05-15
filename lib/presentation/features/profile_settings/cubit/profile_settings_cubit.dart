import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/enums/avatar_type.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/domain/params/update_profile_params.dart';
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
    if (state.loadStatus.isLoading) return;
    emit(state.copyWith(loadStatus: LoadStatus.loading));

    // 1. Load from local cache first
    try {
      final cachedProfile = await authRepository.getCachedProfile();
      if (cachedProfile != null) {
        _emitProfile(cachedProfile, LoadStatus.success);
      }
    } catch (e) {
      // Ignore cache errors
    }

    // 2. Fetch from remote
    // Note: The delay is kept for demonstration purposes if the user still wants to see the shimmer.
    // However, if we have local data, the shimmer might not show for long unless we force it.
    await Future.delayed(const Duration(seconds: 1)); // Reduced from 10s to be more realistic

    try {
      final userProfile = await authRepository.getUserProfile();
      _emitProfile(userProfile, LoadStatus.success);
    } catch (e) {
      // If we already have local data, we might not want to show an error immediately
      if (state.loadStatus != LoadStatus.success) {
        emit(state.copyWith(loadStatus: LoadStatus.failure));
        navigator.flushBar.showError(message: e.toString());
      }
    }
  }

  void _emitProfile(UserProfile userProfile, LoadStatus status) {
    emit(
      state.copyWith(
        loadStatus: status,
        name: userProfile.fullName ?? '',
        email: userProfile.id == 'guest' ? '' : userProfile.id,
        avatarType: AvatarType.fromId(userProfile.avatarTypeId),
        frameType: AvatarFrameType.fromId(userProfile.frameTypeId),
      ),
    );
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void selectAvatar({required AvatarType avatarType}) {
    emit(state.copyWith(avatarType: avatarType));
  }

  void selectFrame({required AvatarFrameType frameType}) {
    emit(state.copyWith(frameType: frameType));
  }

  Future<void> saveProfile() async {
    if (state.updateStatus.isLoading) return;
    emit(state.copyWith(updateStatus: LoadStatus.loading));
    try {
      await authRepository.updateProfile(
        params: UpdateProfileParams(
          fullName: state.name,
          avatarType: state.avatarType.id,
          frameType: state.frameType.id,
        ),
      );
      emit(state.copyWith(updateStatus: LoadStatus.success));
      navigator.flushBar.showSuccess(
        message: S.current.profileUpdatedSuccessfully,
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: LoadStatus.failure));
      navigator.flushBar.showError(message: e.toString());
    }
  }
}
