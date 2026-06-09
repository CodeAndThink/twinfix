import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DeleteAccountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) =>
          previous.deleteAccountStatus != current.deleteAccountStatus,
      builder: (context, state) {
        final isLoading = state.deleteAccountStatus.isLoading;

        return AppScaffold(
          title: l10n.deleteAccountWarningTitle,
          isLoading: isLoading,
          body: SafeArea(
            child: Padding(
              padding: 16.paddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  32.height,
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 80,
                    color: theme.colorScheme.error,
                  ),
                  24.height,
                  Text(
                    l10n.deleteAccountWarningMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  32.height,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _cubit.manageSubscriptions,
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: Text(l10n.manageSubscriptions),
                      style: OutlinedButton.styleFrom(
                        padding: 16.paddingAll,
                        shape: RoundedRectangleBorder(
                          borderRadius: 16.borderRadius,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: 16.paddingAll,
                        shape: RoundedRectangleBorder(
                          borderRadius: 16.borderRadius,
                        ),
                      ),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  16.height,
                  SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: l10n.deleteAccount,
                      onPressed: _cubit.deleteAccount,
                      icon: Icons.delete_forever_rounded,
                      backgroundColor: theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
