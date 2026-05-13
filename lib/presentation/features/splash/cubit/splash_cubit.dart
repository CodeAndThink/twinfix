import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/splash/cubit/splash_state.dart';
import 'package:twinfix/presentation/features/splash/navigator/splash_navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:twinfix/core/services/permission_service.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class SplashCubit extends BaseCubit<SplashState> {
  final SplashNavigator navigator;
  final PermissionService permissionService;

  SplashCubit({required this.navigator, required this.permissionService})
    : super(const SplashState());

  Future<void> init(BuildContext context) async {
    await permissionService.requestPhotoPermission(context);

    final startTime = DateTime.now();

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    final elapsedTime = DateTime.now().difference(startTime);
    final remainingTime = 2.seconds - elapsedTime;

    if (remainingTime > Duration.zero) {
      await Future.delayed(remainingTime);
    }

    if (hasSeenOnboarding) {
      navigator.toScan();
    } else {
      navigator.toOnboarding();
    }
  }
}
