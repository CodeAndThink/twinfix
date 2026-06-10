import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/utils/validate_utils.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/login/cubit/login_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
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
  late ThemeData _theme;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LoginCubit>();
  }

  void _handleLogin() {
    _unfocusAll();
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.login();
    }
  }

  void _unfocusAll() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  void dispose() {
    _cubit.emailController.dispose();
    _cubit.passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      listener: (context, state) {
        if (state.loadStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: AppScaffold(title: _l10n.login, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      builder: (context, state) {
        return SafeArea(
          child: Padding(
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
                        _l10n.welcomeBack,
                        style: _theme.textTheme.headlineMedium?.copyWith(
                          color: _theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      32.height,
                      AppAuthTextField(
                        controller: _cubit.emailController,
                        focusNode: _emailFocusNode,
                        labelText: _l10n.email,
                        isEnable: !state.loadStatus.isLoading,
                        validator: (value) =>
                            ValidateUtils.validateEmail(value: value),
                      ),
                      16.height,
                      AppPasswordTextField(
                        controller: _cubit.passwordController,
                        focusNode: _passwordFocusNode,
                        labelText: _l10n.password,
                        isEnable: !state.loadStatus.isLoading,
                        validator: (value) =>
                            ValidateUtils.validatePassword(value: value),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              _cubit.navigator.goToForgotPassword(),
                          child: Text(
                            _l10n.forgotPasswordQuestion,
                            style: _theme.textTheme.titleSmall?.copyWith(
                              color: _theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: AppFilledButton(
                          onPressed: () => _handleLogin(),
                          isLoading: state.loadStatus.isLoading,
                          text: _l10n.login.toUpperCase(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _cubit.navigator.goToRegister(),
                        child: Text(
                          _l10n.noAccountRegister,
                          style: _theme.textTheme.titleSmall?.copyWith(
                            color: _theme.colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      16.height,
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: 16.paddingHorizontal,
                            child: Text(
                              _l10n.or.toUpperCase(),
                              style: _theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      16.height,
                      IconButton(
                        onPressed: () => _cubit.signInWithGoogle(),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: AppAssetImage(
                          path: AppAssets.googleIcon,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
