import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ForgotPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.forgotPasswordTitle,
      body: SafeArea(
        child: Padding(
          padding: 16.padding,
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listenWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            listener: (context, state) {
              if (state.loadStatus == LoadStatus.success) {
                _cubit.navigator.notify.showSuccess(
                  message: _l10n.resetLinkSent,
                );
                _cubit.navigator.safePop();
              } else if (state.loadStatus == LoadStatus.failure) {
                _cubit.navigator.notify.showError(
                  message: state.errorMessage ?? _l10n.failedToSendResetLink,
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _l10n.forgotPasswordDescription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  32.height,
                  AppAuthTextField(
                    controller: _cubit.emailController,
                    labelText: _l10n.email,
                  ),
                  24.height,
                  AppFilledButton(
                    onPressed: () => _cubit.sendResetLink(),
                    isLoading: state.loadStatus.isLoading,
                    text: _l10n.sendResetLink,
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
