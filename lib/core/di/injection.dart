import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'injection.config.dart';

import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import '../services/auth_service.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await locator.init();
  final prefs = await SharedPreferences.getInstance();
  if (!locator.isRegistered<SharedPreferences>()) {
    locator.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  // Register manually as build_runner failed due to external dependencies
  if (!locator.isRegistered<AppCubit>()) {
    locator.registerLazySingleton(
      () => AppCubit(locator<AuthService>(), locator<UserRepository>()),
    );
  }
  if (!locator.isRegistered<ThemeCubit>()) {
    locator.registerLazySingleton(
      () => ThemeCubit(locator<SharedPreferences>()),
    );
  }
  if (!locator.isRegistered<LocaleCubit>()) {
    locator.registerLazySingleton(
      () => LocaleCubit(locator<SharedPreferences>()),
    );
  }
}
