import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'injection.config.dart';

import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/locale_cubit.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/core/services/iap_service.dart';
import 'package:twinfix/core/services/sync_service.dart';
import 'package:twinfix/core/services/connection_service.dart';

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

  if (!locator.isRegistered<ConnectionService>()) {
    locator.registerLazySingleton(() => ConnectionService());
  }

  // Register manually as build_runner failed due to external dependencies
  if (!locator.isRegistered<SyncService>()) {
    locator.registerLazySingleton(
      () =>
          SyncService(locator<AuthRepository>(), locator<ConnectionService>()),
    );
  }

  if (!locator.isRegistered<AppCubit>()) {
    locator.registerLazySingleton(
      () => AppCubit(
        locator<AuthRepository>(),
        locator<IapService>(),
        locator<SubscriptionCubit>(),
        locator<ConnectionService>(),
        locator<SyncService>(),
      ),
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

  if (!locator.isRegistered<IapService>()) {
    locator.registerLazySingleton(() => IapService());
  }

  if (!locator.isRegistered<SubscriptionCubit>()) {
    locator.registerLazySingleton(
      () => SubscriptionCubit(locator<IapService>(), locator<AuthRepository>()),
    );
  }
}
