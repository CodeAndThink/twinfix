import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/presentation/features/profile_detail/cubit/profile_detail_state.dart';
import 'package:twinfix/presentation/features/profile_detail/navigator/profile_detail_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ProfileDetailCubit extends BaseCubit<ProfileDetailState> {
  final ProfileDetailNavigator navigator;
  final AuthRepository authRepository;

  ProfileDetailCubit({required this.navigator, required this.authRepository})
    : super(const ProfileDetailState());

  Future<void> fetchProfile() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final profile = await authRepository.getUserProfile();
      final user = Supabase.instance.client.auth.currentUser;

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          name: user?.userMetadata?['full_name'] ?? 'User',
          email: user?.email ?? '',
          avatarUrl: user?.userMetadata?['avatar_url'] ?? '',
          totalCleanedBytes: profile.totalCleanedBytes,
          streakDays: profile.streakDays,
          totalDeletedPhotos: profile.totalDeletedPhotos,
          blurryDeletedPhotos: profile.blurryDeletedPhotos,
          duplicateDeletedPhotos: profile.duplicateDeletedPhotos,
          maxDeletedInOneSession: profile.maxDeletedInOneSession,
          isPro: profile.isPro,
          badgeIds: profile.badgeIds,
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

  Future<void> logout({bool force = false}) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.logout(force: force);
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          isLoggedOut: true,
          requiresForceLogout: false,
        ),
      );
    } on UnsyncedDataException catch (_) {
      emit(
        state.copyWith(
          loadStatus:
              LoadStatus.success, // Not a failure, just requires user action
          requiresForceLogout: true,
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
}
