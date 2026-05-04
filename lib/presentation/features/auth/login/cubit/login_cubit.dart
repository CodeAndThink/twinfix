import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/login/cubit/login_state.dart';
import 'package:twinfix/presentation/features/auth/login/navigator/login_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginNavigator navigator;
  final AuthRepository authRepository;

  LoginCubit({required this.navigator, required this.authRepository})
    : super(const LoginState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> login() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.login(email: state.email, password: state.password);
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.safePop();
      navigator.flushBar.showSuccess(message: S.current.loginSuccessfully);
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: S.current.loginFailureMessage,
        ),
      );
      navigator.flushBar.showError(message: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.safePop();
      navigator.flushBar.showSuccess(
        message: S.current.googleLoginSuccessfully,
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: S.current.googleLoginFailed,
        ),
      );
      navigator.flushBar.showError(message: e.toString());
    }
  }
}
