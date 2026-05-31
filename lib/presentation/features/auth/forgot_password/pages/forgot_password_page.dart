import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/utils/validate_utils.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_auth_text_field.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/enums/load_status.dart';
import '../cubit/forgot_password_cubit.dart';
import '../navigator/forgot_password_navigator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        navigator: ForgotPasswordNavigator(context),
        authRepository: locator.get(),
      ),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  late final ForgotPasswordCubit _cubit;
  late S _l10n;
  late ThemeData _theme;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
  }

  void _handleSendResetLink() {
    _unfocusAll();
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.sendResetLink();
    }
  }

  void _unfocusAll() {
    _emailFocusNode.unfocus();
  }

  @override
  void dispose() {
    _cubit.emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(title: _l10n.forgotPasswordTitle, body: _buildBody());
  }

  Widget _buildBody() {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.success) {
          _cubit.navigator.flushBar.showSuccess(message: _l10n.resetLinkSent);
          _cubit.navigator.safePop();
        } else if (state.loadStatus == LoadStatus.failure) {
          _cubit.navigator.flushBar.showError(
            message: state.errorMessage ?? _l10n.failedToSendResetLink,
          );
        }
      },
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
                      _l10n.forgotPasswordDescription,
                      textAlign: TextAlign.center,
                      style: _theme.textTheme.titleMedium?.copyWith(
                        color: _theme.colorScheme.primary,
                      ),
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
                    32.height,
                    SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        onPressed: () => _handleSendResetLink(),
                        isLoading: state.loadStatus.isLoading,
                        text: _l10n.sendResetLink,
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
