import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/delete_account/cubit/delete_account_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/presentation/features/delete_account/navigator/delete_account_navigator.dart';

class DeleteAccountCubit extends BaseCubit<DeleteAccountState> {
  final DeleteAccountNavigator navigator;

  DeleteAccountCubit({required this.navigator})
    : super(const DeleteAccountState());

  Future<void> manageSubscriptions() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final urlString = customerInfo.managementURL;
      if (urlString != null && urlString.isNotEmpty) {
        await AppUtils.instance.openLink(urlString);
      }
    } catch (e) {
      debugPrint('Error launching management URL: $e');
    }
  }

  void deleteAccount() {
    final l10n = S.of(navigator.context);
    final theme = Theme.of(navigator.context);
    navigator.dialog.showConfirm(
      title: l10n.deleteAccount,
      message: l10n.deleteAccountConfirm,
      leftText: l10n.cancel,
      rightText: l10n.delete,
      rightColor: theme.colorScheme.error,
      onRight: () {
        navigator.context.read<AppCubit>().deleteAccount();
        navigator.safePop();
      },
    );
  }
}
