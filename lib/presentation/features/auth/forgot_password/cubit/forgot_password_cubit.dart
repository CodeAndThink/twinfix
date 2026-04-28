import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/navigator/forgot_password_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  final ForgotPasswordNavigator navigator;
  final AuthRepository authRepository;

  ForgotPasswordCubit({required this.navigator, required this.authRepository})
    : super(const ForgotPasswordState());

  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetLink() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.forgotPassword(email: emailController.text.trim());
      emit(state.copyWith(loadStatus: LoadStatus.success));
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
