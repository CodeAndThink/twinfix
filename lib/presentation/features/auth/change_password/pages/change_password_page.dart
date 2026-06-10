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

import 'package:twinfix/presentation/features/auth/change_password/cubit/change_password_cubit.dart';
import 'package:twinfix/presentation/features/auth/change_password/cubit/change_password_state.dart';
import 'package:twinfix/presentation/features/auth/change_password/navigator/change_password_navigator.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        navigator: ChangePasswordNavigator(context),
        authRepository: locator(),
      ),
      child: const ChangePasswordChildPage(),
    );
  }
}

class ChangePasswordChildPage extends StatefulWidget {
  const ChangePasswordChildPage({super.key});

  @override
  State<ChangePasswordChildPage> createState() =>
      _ChangePasswordChildPageState();
}

class _ChangePasswordChildPageState extends State<ChangePasswordChildPage> {
  late final ChangePasswordCubit _cubit;
  late final S _l10n;

  final _formKey = GlobalKey<FormState>();

  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangePasswordCubit>();
  }

  @override
  void dispose() {
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      _cubit.changePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus,
      listener: (context, state) {
        if (state.loadStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
      },
      child: AppScaffold(title: _l10n.changePassword, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                        AppPasswordTextField(
                          controller: _cubit.oldPasswordController,
                          focusNode: _oldPasswordFocusNode,
                          labelText: _l10n.oldPassword,
                          isEnable: !state.loadStatus.isLoading,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return _l10n.passwordRequired;
                            }
                            return null;
                          },
                        ),
                        16.height,
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
                            onPressed: _handleChangePassword,
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
