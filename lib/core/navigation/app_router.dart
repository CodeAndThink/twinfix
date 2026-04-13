import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/features/main/pages/main_page.dart';
import '../../presentation/features/scan/pages/scan_page.dart';
import '../../presentation/features/scan_result/pages/scan_result_page.dart';
import '../../presentation/features/dashboard/pages/dashboard_page.dart';
import '../../presentation/features/onboarding/pages/onboarding_page.dart';
import '../../presentation/features/splash/pages/splash_page.dart';
import '../../presentation/features/achievement_detail/pages/achievement_detail_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static const String splash = 'splash';
  static const String splashPath = '/';

  static const String onboarding = 'onboarding';
  static const String onboardingPath = '/onboarding';

  static const String scan = 'scan';
  static const String scanPath = '/scan';

  static const String scanResult = 'scan_result';
  static const String scanResultPath = '/scan_result';

  static const String dashboard = 'dashboard';
  static const String dashboardPath = '/dashboard';

  static const String achievementDetail = 'achievement_detail';
  static const String achievementDetailPath = 'achievement';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splashPath,
    redirect: (context, state) async {
      // Allow initial splash screen to show
      if (state.matchedLocation == splashPath) return null;

      final prefs = await SharedPreferences.getInstance();
      final hasSeen = prefs.getBool('hasSeenOnboarding') ?? false;
      final isGoingToOnboarding = state.matchedLocation == onboardingPath;

      if (!hasSeen && !isGoingToOnboarding) {
        return onboardingPath;
      }
      if (hasSeen && isGoingToOnboarding) {
        return scanPath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: splashPath,
        name: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: onboardingPath,
        name: onboarding,
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
                path: scanPath,
                name: scan,
                builder: (context, state) => const ScanPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: dashboardPath,
                name: dashboard,
                builder: (context, state) => const DashboardPage(),
                routes: [
                  GoRoute(
                    path: achievementDetailPath,
                    name: achievementDetail,
                    builder: (context, state) {
                      final args = state.extra as AchievementDetailPageArgs;
                      return AchievementDetailPage(args: args);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: scanResultPath,
        name: scanResult,
        builder: (context, state) {
          final args = state.extra as ScanResultPageArgs;
          return ScanResultPage(args: args);
        },
      ),
    ],
  );
}
