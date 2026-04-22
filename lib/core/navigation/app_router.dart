import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/media_type_selection/page/media_type_selection_page.dart';
import 'package:twinfix/presentation/features/media_viewer/page/media_viewer_page.dart';
import 'package:twinfix/presentation/features/other_feature/page/other_feature_page.dart';
import '../../presentation/features/main/pages/main_page.dart';
import '../../presentation/features/scan/pages/scan_page.dart';
import '../../presentation/features/scan_result/pages/scan_result_page.dart';
import '../../presentation/features/achievement/pages/achievement_page.dart';
import '../../presentation/features/onboarding/pages/onboarding_page.dart';
import '../../presentation/features/splash/pages/splash_page.dart';
import '../../presentation/features/achievement_detail/pages/achievement_detail_page.dart';
import '../../presentation/features/settings/pages/settings_page.dart';
import '../../presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import '../../presentation/features/watermark/page/watermark_page.dart';
import '../../presentation/features/image_editor/page/image_editor_page.dart';
import '../../presentation/features/face_blur/page/face_blur_page.dart';
import 'package:twinfix/presentation/features/document_detection/page/document_detection_page.dart';
import 'package:twinfix/presentation/features/remove_gps/page/remove_gps_page.dart';

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

  static const String achievement = 'achievement';
  static const String achievementPath = '/achievement';

  static const String achievementDetail = 'achievement_detail';
  static const String achievementDetailPath = '/achievement_detail';

  static const String settings = 'settings';
  static const String settingsPath = '/settings';

  static const String galleryManager = 'gallery_manager';
  static const String galleryManagerPath = '/gallery_manager';

  static const String confirmDelete = 'confirm_delete';
  static const String confirmDeletePath = '/confirm_delete';

  static const String otherFeature = 'other_feature';
  static const String otherFeaturePath = '/other_feature';

  static const String mediaTypeSelection = 'media_type_selection';
  static const String mediaTypeSelectionPath = '/media_type_selection';

  static const String mediaViewer = 'media_viewer';
  static const String mediaViewerPath = '/media_viewer';

  static const String watermark = 'watermark';
  static const String watermarkPath = '/watermark';

  static const String imageEditor = 'image_editor';
  static const String imageEditorPath = '/image_editor';

  static const String faceBlur = 'face_blur';
  static const String faceBlurPath = '/face_blur';

  static const String documentDetection = 'document_detection';
  static const String documentDetectionPath = '/document_detection';

  static const String removeGPS = 'remove_gps';
  static const String removeGPSPath = '/remove_gps';

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
                path: otherFeaturePath,
                name: otherFeature,
                builder: (context, state) => const OtherFeaturePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: achievementPath,
                name: achievement,
                builder: (context, state) => const AchievementPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settingsPath,
                name: settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: achievementDetailPath,
        name: achievementDetail,
        builder: (context, state) {
          final args = state.extra as AchievementDetailPageArgs;
          return AchievementDetailPage(args: args);
        },
      ),
      GoRoute(
        path: scanResultPath,
        name: scanResult,
        builder: (context, state) {
          final args = state.extra as ScanResultPageArgs;
          return ScanResultPage(args: args);
        },
      ),
      GoRoute(
        path: galleryManagerPath,
        name: galleryManager,
        builder: (context, state) {
          final args = state.extra as GalleryManagerArgs;
          return GalleryManagerPage(args: args);
        },
      ),
      GoRoute(
        path: confirmDeletePath,
        name: confirmDelete,
        builder: (context, state) {
          final args = state.extra as ConfirmDeletePageArgs;
          return ConfirmDeletePage(args: args);
        },
      ),
      GoRoute(
        path: mediaViewerPath,
        name: mediaViewer,
        builder: (context, state) {
          final args = state.extra as MediaViewerArgs;
          return MediaViewerPage(args: args);
        },
      ),
      GoRoute(
        path: mediaTypeSelectionPath,
        name: mediaTypeSelection,
        builder: (context, state) => const MediaTypeSelectionPage(),
      ),
      GoRoute(
        path: watermarkPath,
        name: watermark,
        builder: (context, state) {
          final args = state.extra as WatermarkPageArgs;
          return WatermarkPage(args: args);
        },
      ),
      GoRoute(
        path: imageEditorPath,
        name: imageEditor,
        builder: (context, state) => const ImageEditorPage(),
      ),
      GoRoute(
        path: faceBlurPath,
        name: faceBlur,
        builder: (context, state) {
          final args = state.extra as FaceBlurPageArgs;
          return FaceBlurPage(args: args);
        },
      ),
      GoRoute(
        path: documentDetectionPath,
        name: documentDetection,
        builder: (context, state) => const DocumentDetectionPage(),
      ),
      GoRoute(
        path: removeGPSPath,
        name: removeGPS,
        builder: (context, state) => const RemoveGPSPage(),
      ),
    ],
  );
}
