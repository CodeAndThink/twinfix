import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/navigation/app_router.dart';

class DeeplinkService {
  DeeplinkService._();

  static final DeeplinkService instance = DeeplinkService._();

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

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
      if (uri.host == 'reset-password') {
        router.pushNamed(AppRouter.resetPassword);
      } else if (uri.host == 'auth-success') {
        router.goNamed(AppRouter.login);
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
