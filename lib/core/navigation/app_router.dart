import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/presentation/features/activity_detail/page/activity_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/features/history/cubit/history_cubit.dart';
import 'package:twinfix/presentation/features/history/page/history_page.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/pages/forgot_password_page.dart';
import 'package:twinfix/presentation/features/auth/login/pages/login_page.dart';
import 'package:twinfix/presentation/features/auth/register/pages/register_page.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/media_type_selection/page/media_type_selection_page.dart';
import 'package:twinfix/presentation/features/media_viewer/page/media_viewer_page.dart';
import 'package:twinfix/presentation/features/other_feature/page/other_feature_page.dart';
import '../../presentation/features/main/pages/main_page.dart';
import '../../presentation/features/scan/pages/scan_page.dart';
import '../../presentation/features/scan_loading/pages/scan_loading_page.dart';
import '../../presentation/features/scan_result/pages/scan_result_page.dart';
import '../../presentation/features/achievement/pages/achievement_page.dart';
import '../../presentation/features/badge_gallery/page/badge_gallery_page.dart';

import '../../presentation/features/onboarding/pages/onboarding_page.dart';
import '../../presentation/features/splash/pages/splash_page.dart';
import '../../presentation/features/badge_detail/pages/badge_detail_page.dart';
import '../../presentation/features/settings/pages/settings_page.dart';
import '../../presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import '../../presentation/features/watermark/page/watermark_page.dart';
import '../../presentation/features/image_editor/page/image_editor_page.dart';
import '../../presentation/features/face_blur/page/face_blur_page.dart';
import '../../presentation/app/cubit/subscription_cubit.dart';
import '../di/injection.dart';
import 'package:twinfix/presentation/features/document_detection/page/document_detection_page.dart';
import 'package:twinfix/presentation/features/remove_gps/page/remove_gps_page.dart';
import 'package:twinfix/presentation/features/blur_detection/page/blur_detection_page.dart';
import 'package:twinfix/presentation/features/about/about/page/about_page.dart';
import 'package:twinfix/presentation/features/about/contact/page/contact_page.dart';
import 'package:twinfix/presentation/features/paywall/pages/paywall_page.dart';
import 'package:twinfix/presentation/features/media_timeline/pages/media_timeline_page.dart';
import 'package:twinfix/presentation/features/profile_settings/pages/profile_settings_page.dart';
import 'package:twinfix/presentation/features/delete_account/pages/delete_account_page.dart';
import 'package:twinfix/presentation/features/auth/change_password/pages/change_password_page.dart';
import 'package:twinfix/presentation/features/auth/reset_password/pages/reset_password_page.dart'
    as twinfix_reset_pwd;

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

  static const String badgeGallery = 'badge_gallery';
  static const String badgeGalleryPath = '/badge_gallery';

  static const String badgeDetail = 'badge_detail';
  static const String badgeDetailPath = '/badge_detail';

  static const String activityDetail = 'activity_detail';
  static const String activityDetailPath = '/activity_detail';

  static const String history = 'history';
  static const String historyPath = '/history';

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

  static const String blurDetection = 'blur_detection';
  static const String blurDetectionPath = '/blur_detection';

  static const String aboutUs = 'about_us';
  static const String aboutUsPath = '/about_us';

  static const String privacy = 'privacy';
  static const String privacyPath = '/privacy';

  static const String termsOfService = 'terms_of_service';
  static const String termsOfServicePath = '/terms_of_service';

  static const String contact = 'contact';
  static const String contactPath = '/contact';

  static const String login = 'login';
  static const String loginPath = '/login';

  static const String register = 'register';
  static const String registerPath = '/register';

  static const String forgotPassword = 'forgot_password';
  static const String forgotPasswordPath = '/forgot_password';

  static const String paywall = 'paywall';
  static const String paywallPath = '/paywall';

  static const String scanLoading = 'scan_loading';
  static const String scanLoadingPath = '/scan_loading';

  static const String mediaTimeline = 'media_timeline';
  static const String mediaTimelinePath = '/media_timeline';

  static const String profileSettings = 'profile_settings';
  static const String profileSettingsPath = '/profile_settings';

  static const String deleteAccount = 'delete_account';
  static const String deleteAccountPath = '/delete_account';

  static const String changePassword = 'change_password';
  static const String changePasswordPath = '/change_password';

  static const String resetPassword = 'reset_password';
  static const String resetPasswordPath = '/reset_password';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: splashPath,
    redirect: (context, state) async {
      // Allow initial splash screen to show
      if (state.matchedLocation == splashPath) return null;

      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
      final hasSeenPaywallIntro = prefs.getBool('hasSeenPaywallIntro') ?? false;

      final isGoingToOnboarding = state.matchedLocation == onboardingPath;
      final isGoingToPaywall = state.matchedLocation == paywallPath;

      if (!hasSeenOnboarding) {
        if (isGoingToOnboarding) return null;
        return onboardingPath;
      }

      if (!hasSeenPaywallIntro) {
        final isPremium = locator<SubscriptionCubit>().state.isPremium;
        if (isPremium) {
          await prefs.setBool('hasSeenPaywallIntro', true);
          return null;
        }
        if (isGoingToPaywall) return null;
        return paywallPath;
      }

      if (hasSeenOnboarding && isGoingToOnboarding) {
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
        path: badgeGalleryPath,
        name: badgeGallery,
        builder: (context, state) {
          final args = state.extra as BadgeGalleryPageArgs;
          return BadgeGalleryPage(args: args);
        },
      ),
      GoRoute(
        path: badgeDetailPath,

        name: badgeDetail,
        builder: (context, state) {
          final args = state.extra as BadgeDetailPageArgs;
          return BadgeDetailPage(args: args);
        },
      ),
      GoRoute(
        path: activityDetailPath,
        name: activityDetail,
        builder: (context, state) => const ActivityDetailPage(),
      ),
      GoRoute(
        path: historyPath,
        name: history,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                HistoryCubit(authRepository: locator())..init(),
            child: const HistoryPage(),
          );
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
        builder: (context, state) {
          final args = state.extra as ImageEditorPageArgs;
          return ImageEditorPage(args: args);
        },
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
      GoRoute(
        path: blurDetectionPath,
        name: blurDetection,
        builder: (context, state) => const BlurDetectionPage(),
      ),
      GoRoute(
        path: aboutUsPath,
        name: aboutUs,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: contactPath,
        name: contact,
        builder: (context, state) => const ContactPage(),
      ),
      GoRoute(
        path: loginPath,
        name: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: registerPath,
        name: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: forgotPasswordPath,
        name: forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: paywallPath,
        name: paywall,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        path: scanLoadingPath,
        name: scanLoading,
        builder: (context, state) {
          return ScanLoadingPage();
        },
      ),
      GoRoute(
        path: mediaTimelinePath,
        name: mediaTimeline,
        builder: (context, state) => const MediaTimelinePage(),
      ),
      GoRoute(
        path: profileSettingsPath,
        name: profileSettings,
        builder: (context, state) => const ProfileSettingsPage(),
      ),
      GoRoute(
        path: deleteAccountPath,
        name: deleteAccount,
        builder: (context, state) => const DeleteAccountPage(),
      ),
      GoRoute(
        path: changePasswordPath,
        name: changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: resetPasswordPath,
        name: resetPassword,
        builder: (context, state) =>
            const twinfix_reset_pwd.ResetPasswordPage(), // Using an alias or full path since it shares name
      ),
    ],
  );
}
