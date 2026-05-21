// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;
import 'package:void_chat/core/auth/infrastructure/i_session_expired_handler.dart'
    as _i1021;
import 'package:void_chat/core/auth/infrastructure/session_expired_handler.dart'
    as _i1047;
import 'package:void_chat/core/di/modules.dart' as _i980;
import 'package:void_chat/core/l10n/cubit/l10n_cubit.dart' as _i331;
import 'package:void_chat/core/network/dio_client.dart' as _i139;
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart'
    as _i351;
import 'package:void_chat/core/storage/shared_preferences/app_prefs.dart'
    as _i959;
import 'package:void_chat/core/theme/cubit/theme_cubit.dart' as _i542;
import 'package:void_chat/core/theme/theme_controller.dart' as _i644;
import 'package:void_chat/features/auth/login/data/data_sources/login_remote_data_source.dart'
    as _i301;
import 'package:void_chat/features/auth/login/data/repositories/login_repository_impl.dart'
    as _i869;
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart'
    as _i172;
import 'package:void_chat/features/auth/login/domain/use_cases/login_verify_code_use_case.dart'
    as _i1003;
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_code_use_case.dart'
    as _i656;
import 'package:void_chat/features/auth/login/domain/use_cases/login_with_password_use_case.dart'
    as _i483;
import 'package:void_chat/features/auth/login/presentation/cubit/login_cubit.dart'
    as _i361;
import 'package:void_chat/features/auth/shared/presentation/cubit/auth_cubit.dart'
    as _i265;
import 'package:void_chat/router/app_router.dart' as _i724;
import 'package:void_chat/router/auth_guard.dart' as _i374;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i207.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i644.ThemeController>(() => _i644.ThemeController());
    gh.lazySingleton<_i351.AppSecureStorage>(
      () => _i351.AppSecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i959.AppPrefs>(
      () => _i959.AppPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i265.AuthCubit>(
      () => _i265.AuthCubit(gh<_i351.AppSecureStorage>()),
    );
    gh.lazySingleton<_i1021.ISessionExpiredHandler>(
      () => _i1047.SessionExpiredHandlerImpl(gh<_i265.AuthCubit>()),
    );
    gh.factory<_i331.L10nCubit>(() => _i331.L10nCubit(gh<_i959.AppPrefs>()));
    gh.factory<_i542.ThemeCubit>(() => _i542.ThemeCubit(gh<_i959.AppPrefs>()));
    gh.lazySingleton<_i139.DioClient>(
      () => _i139.DioClient(
        gh<_i207.Talker>(),
        gh<_i351.AppSecureStorage>(),
        gh<_i1021.ISessionExpiredHandler>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i139.DioClient>()),
    );
    gh.lazySingleton<_i374.AuthGuard>(
      () => _i374.AuthGuard(gh<_i265.AuthCubit>()),
    );
    gh.lazySingleton<_i301.LoginRemoteDataSource>(
      () => _i301.LoginRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i724.AppRouter>(
      () => _i724.AppRouter(gh<_i374.AuthGuard>()),
    );
    gh.lazySingleton<_i172.ILoginRepository>(
      () => _i869.LoginRepositoryImpl(
        gh<_i301.LoginRemoteDataSource>(),
        gh<_i351.AppSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i1003.ILoginVerifyCodeUseCase>(
      () => _i1003.LoginVerifyCodeUseCaseImpl(gh<_i172.ILoginRepository>()),
    );
    gh.lazySingleton<_i483.ILoginWithPasswordUseCase>(
      () => _i483.LoginWithPasswordUseCaseImpl(gh<_i172.ILoginRepository>()),
    );
    gh.lazySingleton<_i656.ILoginWithCodeUseCase>(
      () => _i656.LoginWithCodeUseCaseImpl(gh<_i172.ILoginRepository>()),
    );
    gh.factory<_i361.LoginCubit>(
      () => _i361.LoginCubit(
        gh<_i483.ILoginWithPasswordUseCase>(),
        gh<_i656.ILoginWithCodeUseCase>(),
        gh<_i1003.ILoginVerifyCodeUseCase>(),
        gh<_i265.AuthCubit>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i980.RegisterModule {}
