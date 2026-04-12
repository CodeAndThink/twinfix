import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/features/main/pages/main_page.dart';
import '../../presentation/features/scan/pages/scan_page.dart';
import '../../presentation/features/dashboard/pages/dashboard_page.dart';
import '../../presentation/features/onboarding/pages/onboarding_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/scan',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasSeen = prefs.getBool('hasSeenOnboarding') ?? false;
      final isGoingToOnboarding = state.matchedLocation == '/onboarding';

      if (!hasSeen && !isGoingToOnboarding) {
        return '/onboarding';
      }
      if (hasSeen && isGoingToOnboarding) {
        return '/scan';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scan',
                name: 'scan',
                builder: (context, state) => const ScanPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
