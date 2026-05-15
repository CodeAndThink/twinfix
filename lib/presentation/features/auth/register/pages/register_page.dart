import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/utils/validate_utils.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/register/cubit/register_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_auth_text_field.dart';
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
  late ThemeData _theme;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.register();
    }
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
    _theme = Theme.of(context);

    return AppScaffold(title: _l10n.register, body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      builder: (context, state) {
        return Padding(
          padding: 12.paddingAll,
          child: Center(
            child: AppTransparentContainer(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    32.height,
                    Text(
                      _l10n.becomeOneOfUs,
                      style: _theme.textTheme.headlineMedium?.copyWith(
                        color: _theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    32.height,
                    AppTextField(
                      labelText: _l10n.fullName,
                      controller: _cubit.nameController,
                      prefixIcon: Icons.person,
                      validator: (value) =>
                          ValidateUtils.validateName(value: value),
                    ),
                    16.height,
                    AppAuthTextField(
                      labelText: _l10n.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: _cubit.emailController,
                      validator: (value) =>
                          ValidateUtils.validateEmail(value: value),
                    ),
                    16.height,
                    AppPasswordTextField(
                      controller: _cubit.passwordController,
                      labelText: _l10n.password,
                      validator: (value) =>
                          ValidateUtils.validatePassword(value: value),
                    ),
                    16.height,
                    AppPasswordTextField(
                      controller: _cubit.confirmPasswordController,
                      labelText: _l10n.confirmPassword,
                      validator: (value) =>
                          ValidateUtils.validateConfirmPassword(
                            value: value,
                            password: _cubit.passwordController.text,
                          ),
                    ),
                    24.height,
                    SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        onPressed: _handleRegister,
                        isLoading: state.loadStatus.isLoading,
                        text: _l10n.register.toUpperCase(),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _cubit.navigator.safePop(),
                      child: Text(
                        _l10n.alreadyHaveAccountLogin,
                        style: _theme.textTheme.titleSmall?.copyWith(
                          color: _theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
