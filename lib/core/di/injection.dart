import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
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
  // Register manually as build_runner failed due to external dependencies
  if (!locator.isRegistered<AppCubit>()) {
    locator.registerLazySingleton(() => AppCubit(locator<AuthService>()));
  }
  if (!locator.isRegistered<ThemeCubit>()) {
    locator.registerLazySingleton(() => ThemeCubit());
  }
  if (!locator.isRegistered<LocaleCubit>()) {
    locator.registerLazySingleton(() => LocaleCubit());
  }
}
