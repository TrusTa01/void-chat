// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:backend/app_module.dart' as _i974;
import 'package:backend/core/di/modules.dart' as _i837;
import 'package:backend/core/security/password_hasher.dart' as _i701;
import 'package:backend/features/auth/api/auth_api.dart' as _i592;
import 'package:backend/features/auth/data/repository/postgres_user_repo.dart'
    as _i175;
import 'package:backend/features/auth/domain/repository/i_user_repository.dart'
    as _i278;
import 'package:backend/features/auth/domain/usecases/i_register_user.dart'
    as _i886;
import 'package:backend/features/auth/domain/usecases/register_user.dart'
    as _i799;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:postgres/postgres.dart' as _i103;
import 'package:shelf_router/shelf_router.dart' as _i278;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i278.Router>(() => registerModule.router);
    gh.lazySingleton<_i993.Talker>(() => registerModule.talker);
    gh.lazySingleton<_i103.Pool<_i103.Connection>>(() => registerModule.pool);
    gh.lazySingleton<_i701.PasswordHasher>(
      () => _i701.Argon2idPasswordHasher(
        memory: gh<int>(),
        iterations: gh<int>(),
        parallelism: gh<int>(),
        hashLength: gh<int>(),
        saltLength: gh<int>(),
      ),
    );
    gh.lazySingleton<_i278.IUserRepository>(
      () => _i175.PostgresUserRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i799.IRegisterUser>(
      () => _i799.RegisterUser(
        gh<_i278.IUserRepository>(),
        gh<_i701.PasswordHasher>(),
      ),
    );
    gh.lazySingleton<_i592.AuthApi>(
      () => _i592.AuthApi(gh<_i886.IRegisterUser>()),
    );
    gh.lazySingleton<_i974.AppModule>(
      () => _i974.AppModule(gh<_i278.Router>(), gh<_i592.AuthApi>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i837.RegisterModule {}
