// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/device_storage_datasource.dart' as _i870;
import '../../data/datasources/native/scanner_native_datasource.dart' as _i501;
import '../../data/datasources/photo_local_datasource.dart' as _i366;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/photo_repository_impl.dart' as _i747;
import '../../data/repositories/storage_repository_impl.dart' as _i47;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/photo_repository.dart' as _i236;
import '../../domain/repositories/storage_repository.dart' as _i101;
import '../../domain/usecases/get_photos_usecase.dart' as _i997;
import '../../presentation/app/cubit/app_cubit.dart' as _i541;
import '../../presentation/app/cubit/locale_cubit.dart' as _i733;
import '../../presentation/app/cubit/subscription_cubit.dart' as _i784;
import '../../presentation/app/cubit/theme_cubit.dart' as _i344;
import '../services/connection_service.dart' as _i727;
import '../services/iap_service.dart' as _i1;
import '../services/permission_service.dart' as _i165;
import '../services/sync_service.dart' as _i979;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.lazySingletonAsync<_i214.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i727.ConnectionService>(() => _i727.ConnectionService());
    gh.lazySingleton<_i1.IapService>(() => _i1.IapService());
    gh.lazySingleton<_i165.PermissionService>(() => _i165.PermissionService());
    gh.lazySingleton<_i870.DeviceStorageDataSource>(
      () => _i870.DeviceStorageDataSource(),
    );
    gh.lazySingleton<_i501.ScannerNativeDataSource>(
      () => _i501.ScannerNativeDataSource(),
    );
    gh.lazySingleton<_i366.PhotoLocalDataSource>(
      () => _i366.PhotoLocalDataSource(
        isar: gh<_i214.Isar>(),
        prefs: gh<_i460.SharedPreferences>(),
        nativeScanner: gh<_i501.ScannerNativeDataSource>(),
      ),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(isar: gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i733.LocaleCubit>(
      () => _i733.LocaleCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i344.ThemeCubit>(
      () => _i344.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i979.SyncService>(
      () => _i979.SyncService(
        gh<_i1073.AuthRepository>(),
        gh<_i727.ConnectionService>(),
      ),
    );
    gh.lazySingleton<_i101.StorageRepository>(
      () => _i47.StorageRepositoryImpl(gh<_i870.DeviceStorageDataSource>()),
    );
    gh.lazySingleton<_i236.PhotoRepository>(
      () => _i747.PhotoRepositoryImpl(
        localDataSource: gh<_i366.PhotoLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i784.SubscriptionCubit>(
      () => _i784.SubscriptionCubit(
        gh<_i1.IapService>(),
        gh<_i1073.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i997.GetPhotosUseCase>(
      () => _i997.GetPhotosUseCase(repository: gh<_i236.PhotoRepository>()),
    );
    gh.lazySingleton<_i541.AppCubit>(
      () => _i541.AppCubit(
        gh<_i1073.AuthRepository>(),
        gh<_i1.IapService>(),
        gh<_i784.SubscriptionCubit>(),
        gh<_i727.ConnectionService>(),
        gh<_i979.SyncService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
