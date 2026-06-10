import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

import 'change_password_state.dart';
import '../navigator/change_password_navigator.dart';

class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  final ChangePasswordNavigator navigator;
  final AuthRepository authRepository;

  ChangePasswordCubit({required this.navigator, required this.authRepository})
    : super(const ChangePasswordState());

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> changePassword() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.flushBar.showSuccess(message: S.current.changePasswordSuccess);
      navigator.safePop();
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
