import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

import 'reset_password_state.dart';
import '../navigator/reset_password_navigator.dart';

class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  final ResetPasswordNavigator navigator;
  final AuthRepository authRepository;

  ResetPasswordCubit({required this.navigator, required this.authRepository})
    : super(const ResetPasswordState());

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> updatePassword() async {
    final newPassword = newPasswordController.text.trim();

    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.updatePassword(newPassword: newPassword);
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.flushBar.showSuccess(message: S.current.changePasswordSuccess);
      navigator.goToHome();
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      navigator.flushBar.showError(message: S.current.failedToChangePassword);
    }
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
