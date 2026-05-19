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
import 'package:backend/src/features/auth/register/complete_profile/data/repositories/complete_profile_repository.dart'
    as _i994;
import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart'
    as _i310;
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart'
    as _i717;
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/validate_complete_profile_input_use_case.dart'
    as _i965;
import 'package:backend/src/features/auth/register/start/data/repository/postgres_pending_registration_repository.dart'
    as _i214;
import 'package:backend/src/features/auth/register/start/domain/repository/i_pending_registration_repository.dart'
    as _i449;
import 'package:backend/src/features/auth/register/start/domain/services/dev_email_sender.dart'
    as _i999;
import 'package:backend/src/features/auth/register/start/domain/services/email_code.dart'
    as _i469;
import 'package:backend/src/features/auth/register/start/domain/services/i_email_sender.dart'
    as _i49;
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart'
    as _i517;
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_validate_use_case.dart'
    as _i476;
import 'package:backend/src/features/auth/register/verify_email/data/repositories/verify_email_registration_repository.dart'
    as _i1058;
import 'package:backend/src/features/auth/register/verify_email/domain/repositories/i_verify_email_registration_repository.dart'
    as _i359;
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart'
    as _i136;
import 'package:backend/src/features/auth/shared/data/repository/postgres_session_repository.dart'
    as _i549;
import 'package:backend/src/features/auth/shared/data/repository/postgres_user_repository.dart'
    as _i164;
import 'package:backend/src/features/auth/shared/domain/policies/registration_policies.dart'
    as _i287;
import 'package:backend/src/features/auth/shared/domain/repository/i_session_repository.dart'
    as _i251;
import 'package:backend/src/features/auth/shared/domain/repository/i_user_repository.dart'
    as _i499;
import 'package:backend/src/features/auth/shared/domain/services/password_hasher.dart'
    as _i921;
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart'
    as _i375;
import 'package:backend/src/features/auth/shared/domain/usecases/login_user.dart'
    as _i333;
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
    gh.lazySingleton<_i287.DisplayNamePolicy>(
      () => const _i287.ReservedDisplayNamePolicy(),
    );
    gh.lazySingleton<_i375.SessionToken>(() => _i375.OpaqueBearerToken());
    gh.lazySingleton<_i287.EmailPolicy>(
      () => const _i287.BlocklistEmailPolicy(),
    );
    gh.lazySingleton<_i287.LoginPolicy>(
      () => const _i287.BlacklistLoginPolicy(),
    );
    gh.lazySingleton<_i921.PasswordHasher>(
      () => const _i921.Argon2idPasswordHasher(),
    );
    gh.lazySingleton<_i287.UsernamePolicy>(
      () => const _i287.BlacklistUsernamePolicy(),
    );
    gh.lazySingleton<_i49.EmailCodeSenderService>(
      () => _i999.DevEmailSender(gh<_i993.Talker>()),
    );
    gh.lazySingleton<_i251.ISessionRepository>(
      () => _i549.PostgresSessionRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i359.IVerifyEmailRegistrationRepository>(
      () => _i1058.VerifyEmailRegistrationRepository(
        gh<_i103.Pool<_i103.Connection>>(),
      ),
    );
    gh.lazySingleton<_i499.IUserRepository>(
      () => _i164.PostgresUserRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i965.IValidateCompleteProfileInputUseCase>(
      () => _i965.ValidateCompleteProfileInputUseCase(
        gh<_i287.UsernamePolicy>(),
        gh<_i287.DisplayNamePolicy>(),
      ),
    );
    gh.lazySingleton<_i310.ICompleteProfileRepository>(
      () => _i994.CompleteProfileRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i476.IStartRegistrationValidateUseCase>(
      () => _i476.StartRegistrationValidateUseCase(
        gh<_i287.LoginPolicy>(),
        gh<_i287.EmailPolicy>(),
      ),
    );
    gh.lazySingleton<_i449.IPendingRegistrationRepository>(
      () => _i214.PostgresPendingRegistrationRepository(
        gh<_i103.Pool<_i103.Connection>>(),
      ),
    );
    gh.lazySingleton<_i717.ICompleteRegistrationProfileUseCase>(
      () => _i717.CompleteRegistrationProfileUseCase(
        gh<_i310.ICompleteProfileRepository>(),
        gh<_i499.IUserRepository>(),
        gh<_i965.IValidateCompleteProfileInputUseCase>(),
      ),
    );
    gh.lazySingleton<_i469.EmailCodeService>(
      () => _i469.EmailCodeServiceImpl(gh<_i921.PasswordHasher>()),
    );
    gh.lazySingleton<_i517.IStartRegistrationUseCase>(
      () => _i517.StartRegistrationUseCase(
        gh<_i476.IStartRegistrationValidateUseCase>(),
        gh<_i921.PasswordHasher>(),
        gh<_i469.EmailCodeService>(),
        gh<_i449.IPendingRegistrationRepository>(),
        gh<_i49.EmailCodeSenderService>(),
      ),
    );
    gh.lazySingleton<_i136.IVerifyRegistrationEmailUseCase>(
      () => _i136.VerifyRegistrationEmailUseCase(
        gh<_i359.IVerifyEmailRegistrationRepository>(),
        gh<_i469.EmailCodeService>(),
      ),
    );
    gh.lazySingleton<_i333.ILoginUser>(
      () => _i333.LoginUser(
        gh<_i499.IUserRepository>(),
        gh<_i251.ISessionRepository>(),
        gh<_i921.PasswordHasher>(),
        gh<_i375.SessionToken>(),
      ),
    );
    gh.lazySingleton<_i48.AuthApi>(
      () => _i48.AuthApi(
        gh<_i333.ILoginUser>(),
        gh<_i717.ICompleteRegistrationProfileUseCase>(),
        gh<_i517.IStartRegistrationUseCase>(),
        gh<_i136.IVerifyRegistrationEmailUseCase>(),
      ),
    );
    gh.lazySingleton<_i371.AppModule>(
      () => _i371.AppModule(gh<_i278.Router>(), gh<_i48.AuthApi>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i148.RegisterModule {}
