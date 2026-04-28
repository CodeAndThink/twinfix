import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/login/cubit/login_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
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
        authRepository: context.read<AuthRepository>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  late final LoginCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
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
                  TextField(
                    onChanged: (value) => _cubit.emailChanged(value),
                    decoration: InputDecoration(
                      labelText: _l10n.email,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  16.height,
                  TextField(
                    onChanged: (value) => _cubit.passwordChanged(value),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: _l10n.password,
                      border: const OutlineInputBorder(),
                    ),
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
