import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/register/cubit/register_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_password_text_field.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_text_field.dart';
import '../../../../../core/extensions/extensions.dart';
import '../cubit/register_cubit.dart';
import '../navigator/register_navigator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        navigator: RegisterNavigator(context),
        authRepository: locator.get(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  late final RegisterCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
  }

  @override
  void dispose() {
    _cubit.nameController.dispose();
    _cubit.emailController.dispose();
    _cubit.passwordController.dispose();
    _cubit.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: 16.padding,
          child: BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  32.height,
                  Text(
                    _l10n.createAccount,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  32.height,
                  AppTextField(
                    labelText: _l10n.fullName,
                    controller: _cubit.nameController,
                  ),
                  16.height,
                  AppTextField(
                    labelText: _l10n.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: _cubit.emailController,
                  ),
                  16.height,
                  AppPasswordTextField(
                    controller: _cubit.passwordController,
                    labelText: _l10n.password,
                  ),
                  16.height,
                  AppPasswordTextField(
                    controller: _cubit.confirmPasswordController,
                    labelText: _l10n.confirmPassword,
                  ),
                  24.height,
                  AppFilledButton(
                    onPressed: () => context.read<RegisterCubit>().register(),
                    isLoading: state.loadStatus.isLoading,
                    text: _l10n.register,
                  ),
                  16.height,
                  TextButton(
                    onPressed: () => _cubit.navigator.safePop(),
                    child: Text(_l10n.alreadyHaveAccountLogin),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
