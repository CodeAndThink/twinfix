import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/register/cubit/register_state.dart';
import 'package:twinfix/presentation/features/auth/register/navigator/register_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  final RegisterNavigator navigator;
  final AuthRepository authRepository;

  RegisterCubit({required this.navigator, required this.authRepository})
    : super(const RegisterState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      await authRepository.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        fullName: nameController.text.trim(),
      );
      emit(state.copyWith(loadStatus: LoadStatus.success));
      navigator.dialog.showConfirm(
        title: S.current.registerSuccess,
        message: S.current.registerSuccessMessage,
        rightText: S.current.ok,
        onRight: () => navigator.safePop(),
      );
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
      navigator.flushBar.showError(message: e.toString());
    }
  }
}
