// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:backend/src/app_module.dart' as _i371;
import 'package:backend/src/core/di/modules.dart' as _i148;
import 'package:backend/src/features/auth/auth_controller.dart' as _i48;
import 'package:backend/src/features/auth/data/repository/postgres_session_repository.dart'
    as _i469;
import 'package:backend/src/features/auth/data/repository/postgres_user_repository.dart'
    as _i253;
import 'package:backend/src/features/auth/domain/policies/registration_policies.dart'
    as _i719;
import 'package:backend/src/features/auth/domain/repository/i_session_repository.dart'
    as _i757;
import 'package:backend/src/features/auth/domain/repository/i_user_repository.dart'
    as _i514;
import 'package:backend/src/features/auth/domain/services/password_hasher.dart'
    as _i443;
import 'package:backend/src/features/auth/domain/services/session_token.dart'
    as _i741;
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart'
    as _i1059;
import 'package:backend/src/features/auth/domain/usecases/login_user.dart'
    as _i3;
import 'package:backend/src/features/auth/domain/usecases/register_user.dart'
    as _i231;
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
    gh.lazySingleton<_i443.PasswordHasher>(
      () => const _i443.Argon2idPasswordHasher(),
    );
    gh.lazySingleton<_i741.SessionToken>(() => _i741.OpaqueBearerToken());
    gh.lazySingleton<_i719.UsernamePolicy>(
      () => const _i719.BlacklistUsernamePolicy(),
    );
    gh.lazySingleton<_i719.EmailPolicy>(
      () => const _i719.BlocklistEmailPolicy(),
    );
    gh.lazySingleton<_i719.LoginPolicy>(
      () => const _i719.BlacklistLoginPolicy(),
    );
    gh.lazySingleton<_i719.DisplayNamePolicy>(
      () => const _i719.ReservedDisplayNamePolicy(),
    );
    gh.lazySingleton<_i757.ISessionRepository>(
      () => _i469.PostgresSessionRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i514.IUserRepository>(
      () => _i253.PostgresUserRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i231.IRegisterUser>(
      () => _i231.RegisterUser(
        gh<_i514.IUserRepository>(),
        gh<_i443.PasswordHasher>(),
        gh<_i719.LoginPolicy>(),
        gh<_i719.EmailPolicy>(),
        gh<_i719.UsernamePolicy>(),
        gh<_i719.DisplayNamePolicy>(),
      ),
    );
    gh.lazySingleton<_i3.ILoginUser>(
      () => _i3.LoginUser(
        gh<_i514.IUserRepository>(),
        gh<_i757.ISessionRepository>(),
        gh<_i443.PasswordHasher>(),
        gh<_i741.SessionToken>(),
      ),
    );
    gh.lazySingleton<_i48.AuthApi>(
      () => _i48.AuthApi(gh<_i3.ILoginUser>(), gh<_i1059.IRegisterUser>()),
    );
    gh.lazySingleton<_i371.AppModule>(
      () => _i371.AppModule(gh<_i278.Router>(), gh<_i48.AuthApi>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i148.RegisterModule {}
