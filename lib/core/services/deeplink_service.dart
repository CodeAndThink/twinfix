import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/widgets/dialogs/app_dialog.dart';
import 'package:twinfix/generated/l10n.dart';

class DeeplinkService {
  DeeplinkService._();

  static final DeeplinkService instance = DeeplinkService._();

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;
  bool hasHandledDeepLink = false;

  void init(GoRouter router) {
    _subscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleUri(uri, router);
      },
      onError: (err) {
        debugPrint('Deeplink error: $err');
      },
    );

    _handleInitialUri(router);
  }

  Future<void> _handleInitialUri(GoRouter router) async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleUri(initialUri, router);
        });
      }
    } catch (e) {
      debugPrint('Failed to get initial uri: $e');
    }
  }

  void _handleUri(Uri uri, GoRouter router) {
    if (uri.scheme == 'twinfix') {
      hasHandledDeepLink = true;

      String? error;
      String? errorDescription;

      if (uri.queryParameters.containsKey('error')) {
        error = uri.queryParameters['error'];
        errorDescription = uri.queryParameters['error_description'];
      } else if (uri.fragment.isNotEmpty) {
        final fragmentParams = Uri.splitQueryString(uri.fragment);
        if (fragmentParams.containsKey('error')) {
          error = fragmentParams['error'];
          errorDescription = fragmentParams['error_description'];
        }
      }

      if (uri.host == 'reset-password') {
        router.goNamed(AppRouter.resetPassword);

        if (error != null) {
          // Wait for navigation to complete before showing dialog
          Future.delayed(const Duration(milliseconds: 500), () {
            final context = AppRouter.rootNavigatorKey.currentContext;
            if (context != null && context.mounted) {
              AppDialog(context)
                  .showError(
                    title: S.current.errorTitle,
                    message:
                        errorDescription ?? S.current.invalidTokenOrExpired,
                  )
                  .then((_) {
                    router.goNamed(AppRouter.scan);
                  });
            }
          });
        }
      } else if (uri.host == 'auth-success') {
        router.goNamed(
          AppRouter.authVerification,
          queryParameters: {
            // Keep explicit checks for IDE analyzers without null-aware elements.
            // ignore: use_null_aware_elements
            if (error != null) 'error': error,
            // ignore: use_null_aware_elements
            if (errorDescription != null) 'error_description': errorDescription,
          },
        );
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
