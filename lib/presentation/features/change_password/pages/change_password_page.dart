import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/change_password/cubit/change_password_cubit.dart';
import 'package:twinfix/presentation/features/change_password/cubit/change_password_state.dart';
import 'package:twinfix/presentation/features/change_password/navigator/change_password_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_text_field.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        navigator: ChangePasswordNavigator(context),
        authRepository: locator<AuthRepository>(),
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
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChangePasswordCubit>();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.changePassword,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: 16.paddingAll,
          child: Column(
            children: [
              AppTransparentContainer(
                padding: 16.paddingAll,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _oldPasswordController,
                      labelText: _l10n.oldPassword,
                      obscureText: true,
                      onChanged: _cubit.updateOldPassword,
                    ),
                    16.height,
                    AppTextField(
                      controller: _newPasswordController,
                      labelText: _l10n.newPassword,
                      obscureText: true,
                      onChanged: _cubit.updateNewPassword,
                    ),
                    16.height,
                    AppTextField(
                      controller: _confirmPasswordController,
                      labelText: _l10n.confirmPassword,
                      obscureText: true,
                      onChanged: _cubit.updateConfirmPassword,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              12.height,
              SafeArea(child: _buildBottomButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          current.loadStatus != previous.loadStatus,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: AppFilledButton(
            onPressed: state.loadStatus.isLoading
                ? null
                : _cubit.changePassword,
            text: _l10n.save,
            isLoading: state.loadStatus.isLoading,
          ),
        );
      },
    );
  }
}
