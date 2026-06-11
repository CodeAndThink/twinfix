import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/utils/validate_utils.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_password_text_field.dart';

import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';
import '../navigator/reset_password_navigator.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        navigator: ResetPasswordNavigator(context),
        authRepository: locator(),
      ),
      child: const ResetPasswordChildPage(),
    );
  }
}

class ResetPasswordChildPage extends StatefulWidget {
  const ResetPasswordChildPage({super.key});

  @override
  State<ResetPasswordChildPage> createState() => _ResetPasswordChildPageState();
}

class _ResetPasswordChildPageState extends State<ResetPasswordChildPage> {
  late final ResetPasswordCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  final _formKey = GlobalKey<FormState>();

  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ResetPasswordCubit>();
  }

  @override
  void dispose() {
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      _cubit.updatePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      listener: (context, state) {
        if (state.loadStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: AppScaffold(
        title: _l10n.changePassword,
        body: _buildBody(),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: 12.paddingAll,
            child: Center(
              child: AppTransparentContainer(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        16.height,
                        Text(
                          _l10n.changePassword,
                          style: _theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.height,
                        Text(
                          _l10n.newPassword,
                          textAlign: TextAlign.center,
                          style: _theme.textTheme.bodyMedium,
                        ),
                        24.height,
                        AppPasswordTextField(
                          controller: _cubit.newPasswordController,
                          focusNode: _newPasswordFocusNode,
                          labelText: _l10n.newPassword,
                          isEnable: !state.loadStatus.isLoading,
                          validator: (value) =>
                              ValidateUtils.validatePassword(value: value),
                        ),
                        16.height,
                        AppPasswordTextField(
                          controller: _cubit.confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          labelText: _l10n.confirmPassword,
                          isEnable: !state.loadStatus.isLoading,
                          validator: (value) =>
                              ValidateUtils.validateConfirmPassword(
                                password: _cubit.newPasswordController.text,
                                value: value,
                              ),
                        ),
                        32.height,
                        SizedBox(
                          width: double.infinity,
                          child: AppFilledButton(
                            onPressed: _handleResetPassword,
                            isLoading: state.loadStatus.isLoading,
                            text: _l10n.changePassword,
                          ),
                        ),
                        16.height,
                      ],
                    ),
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
