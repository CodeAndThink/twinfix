import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/buttons/app_outline_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/features/delete_account/cubit/delete_account_cubit.dart';
import 'package:twinfix/presentation/features/delete_account/navigator/delete_account_navigator.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeleteAccountCubit(navigator: DeleteAccountNavigator(context)),
      child: const DeleteAccountChildPage(),
    );
  }
}

class DeleteAccountChildPage extends StatefulWidget {
  const DeleteAccountChildPage({super.key});

  @override
  State<DeleteAccountChildPage> createState() => _DeleteAccountChildPageState();
}

class _DeleteAccountChildPageState extends State<DeleteAccountChildPage> {
  late final DeleteAccountCubit _cubit;
  bool _isUnderstood = false;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DeleteAccountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) =>
          previous.deleteAccountStatus != current.deleteAccountStatus,
      listener: (context, state) {
        if (state.deleteAccountStatus.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
        if (state.deleteAccountStatus.isSuccess) {
          _cubit.navigator.goToSettings();
        }
      },
      child: AppScaffold(
        isShowBackground: false,
        title: l10n.deleteAccountWarningTitle,
        body: SafeArea(
          child: Padding(
            padding: 12.paddingAll,
            child: Column(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 80,
                  color: theme.colorScheme.error,
                ),
                12.height,
                Expanded(
                  child: AppTransparentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.deleteAccountWarningMessage,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                                32.height,
                                SizedBox(
                                  width: double.infinity,
                                  child: AppOutlineButton(
                                    onPressed: _cubit.manageSubscriptions,
                                    icon: Icons.open_in_new_rounded,
                                    text: l10n.manageSubscriptions,
                                    foregroundColor: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isUnderstood = !_isUnderstood;
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isUnderstood,
                                onChanged: (value) {
                                  setState(() {
                                    _isUnderstood = value ?? false;
                                  });
                                },
                                activeColor: theme.colorScheme.error,
                              ),
                              Expanded(
                                child: Text(
                                  l10n.iUnderstandDeleteConsequences,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        16.height,
                        Row(
                          children: [
                            Expanded(
                              child: AppFilledButton(
                                text: l10n.deleteAccount,
                                onPressed: _isUnderstood
                                    ? _cubit.deleteAccount
                                    : null,
                                icon: Icons.delete_forever_rounded,
                                backgroundColor: theme.colorScheme.error,
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: AppOutlineButton(
                                onPressed: () => _cubit.navigator.safePop(),
                                text: l10n.cancel,
                                foregroundColor: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
