import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/login/cubit/login_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_auth_text_field.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_password_text_field.dart';
import '../../../../../core/extensions/extensions.dart';
import '../cubit/login_cubit.dart';
import '../navigator/login_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        navigator: LoginNavigator(context),
        authRepository: locator.get(),
      ),
      child: const _LoginChildPage(),
    );
  }
}

class _LoginChildPage extends StatefulWidget {
  const _LoginChildPage();

  @override
  State<_LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<_LoginChildPage> {
  late final LoginCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
  }

  @override
  void dispose() {
    _cubit.emailController.dispose();
    _cubit.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.login,
      body: SafeArea(
        child: Padding(
          padding: 16.padding,
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _l10n.welcomeBack,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  32.height,
                  AppAuthTextField(
                    controller: _cubit.emailController,
                    labelText: _l10n.email,
                  ),
                  16.height,
                  AppPasswordTextField(
                    controller: _cubit.passwordController,
                    labelText: _l10n.password,
                  ),
                  24.height,
                  AppFilledButton(
                    onPressed: () => _cubit.login(),
                    isLoading: state.loadStatus.isLoading,
                    text: _l10n.login,
                  ),
                  16.height,
                  TextButton(
                    onPressed: () => _cubit.navigator.goToRegister(),
                    child: Text(_l10n.noAccountRegister),
                  ),
                  8.height,
                  TextButton(
                    onPressed: () => _cubit.navigator.goToForgotPassword(),
                    child: Text(_l10n.forgotPasswordQuestion),
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
