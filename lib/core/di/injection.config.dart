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
import 'package:twinfix/presentation/app/cubit/app_cubit.dart' as _i375;
import 'package:twinfix/presentation/features/onboarding/cubit/onboarding_cubit.dart'
    as _i1021;
import 'package:twinfix/presentation/features/onboarding/navigator/onboarding_navigator.dart'
    as _i1022;

import '../../data/datasources/photo_local_datasource.dart' as _i366;
import '../../data/repositories/photo_repository_impl.dart' as _i747;
import '../../domain/repositories/photo_repository.dart' as _i236;
import '../../domain/usecases/get_photos_usecase.dart' as _i997;
import '../../presentation/features/dashboard/cubit/dashboard_cubit.dart'
    as _i510;
import '../../presentation/features/scan/cubit/scan_cubit.dart' as _i1020;
import '../repositories/user_repository.dart' as _i640;
import '../services/auth_service.dart' as _i745;
import '../services/permission_service.dart' as _i165;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i745.AuthService>(() => _i745.AuthService());
    await gh.lazySingletonAsync<_i214.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.lazySingleton<_i1022.OnboardingNavigator>(
        () => _i1022.OnboardingNavigator());
    gh.lazySingleton<_i1021.OnboardingCubit>(
        () => _i1021.OnboardingCubit(navigator: gh<_i1022.OnboardingNavigator>()));
    gh.lazySingleton<_i165.PermissionService>(() => _i165.PermissionService());
    gh.lazySingleton<_i640.UserRepository>(
      () => _i640.UserRepository(authService: gh<_i745.AuthService>()),
    );
    gh.factory<_i510.DashboardCubit>(
      () => _i510.DashboardCubit(
        userRepository: gh<_i640.UserRepository>(),
        globalAppCubit: gh<_i375.AppCubit>(),
      ),
    );
    gh.lazySingleton<_i366.PhotoLocalDataSource>(
      () => _i366.PhotoLocalDataSource(isar: gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i236.PhotoRepository>(
      () => _i747.PhotoRepositoryImpl(
        localDataSource: gh<_i366.PhotoLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i997.GetPhotosUseCase>(
      () => _i997.GetPhotosUseCase(repository: gh<_i236.PhotoRepository>()),
    );
    gh.factory<_i1020.ScanCubit>(
      () => _i1020.ScanCubit(
        getPhotosUseCase: gh<_i997.GetPhotosUseCase>(),
        userRepository: gh<_i640.UserRepository>(),
        globalAppCubit: gh<_i375.AppCubit>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
