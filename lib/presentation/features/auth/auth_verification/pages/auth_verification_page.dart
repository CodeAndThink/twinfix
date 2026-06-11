import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class AuthVerificationPage extends StatefulWidget {
  final String? error;
  final String? errorDescription;

  const AuthVerificationPage({super.key, this.error, this.errorDescription});

  @override
  State<AuthVerificationPage> createState() => _AuthVerificationPageState();
}

class _AuthVerificationPageState extends State<AuthVerificationPage> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final appState = context.read<AppCubit>().state;
      final isLoggedIn = appState.authStatus.isSuccess;

      if (isLoggedIn) {
        context.goNamed(AppRouter.settings);
      } else {
        if (widget.error == null) {
          context.goNamed(AppRouter.login);
        } else {
          context.goNamed(AppRouter.settings);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null && widget.error!.isNotEmpty;
    final l10n = S.of(context);
    final theme = Theme.of(context);

    String message = l10n.verificationSuccess;
    if (hasError) {
      if (widget.error == 'unauthorized_client' ||
          widget.error == 'access_denied') {
        message = l10n.invalidTokenOrExpired;
      } else {
        message =
            (widget.errorDescription != null &&
                widget.errorDescription!.isNotEmpty)
            ? widget.errorDescription!
            : l10n.unknownError;
      }
    }

    return AppScaffold(
      automaticallyImplyLeading: false,
      body: Center(
        child: Padding(
          padding: 12.paddingAll,
          child: AppTransparentContainer(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasError ? Icons.error_outline : Icons.check_circle_outline,
                  size: 80,
                  color: hasError
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                24.height,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                  ),
                ),
                32.height,
                const CircularProgressIndicator(),
                12.height,
                Text(
                  l10n.pleaseWaitWhileWeAreRedirectingYou,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
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
