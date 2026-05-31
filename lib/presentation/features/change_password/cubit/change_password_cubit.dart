import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/change_password/cubit/change_password_state.dart';
import 'package:twinfix/presentation/features/change_password/navigator/change_password_navigator.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordNavigator navigator;
  final AuthRepository authRepository;

  ChangePasswordCubit({required this.navigator, required this.authRepository})
    : super(const ChangePasswordState());

  void updateOldPassword(String password) {
    emit(state.copyWith(oldPassword: password));
  }

  void updateNewPassword(String password) {
    emit(state.copyWith(newPassword: password));
  }

  void updateConfirmPassword(String password) {
    emit(state.copyWith(confirmPassword: password));
  }

  Future<void> changePassword() async {
    if (state.loadStatus.isLoading) return;

    if (state.oldPassword.isEmpty ||
        state.newPassword.isEmpty ||
        state.confirmPassword.isEmpty) {
      navigator.flushBar.showError(message: S.current.pleaseFillAllFields);
      return;
    }

    if (state.newPassword.length < 6) {
      navigator.flushBar.showError(message: S.current.passwordTooShort);
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      navigator.flushBar.showError(message: S.current.passwordsDoNotMatch);
      return;
    }

    emit(state.copyWith(loadStatus: LoadStatus.loading));

    try {
      await authRepository.changePassword(
        oldPassword: state.oldPassword,
        newPassword: state.newPassword,
      );
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.flushBar.showSuccess(message: S.current.changePasswordSuccess);
      navigator.safePop();
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
      navigator.flushBar.showError(message: S.current.failedToChangePassword);
    }
  }
}
