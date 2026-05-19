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
import 'package:backend/src/features/auth/login/password/data/repositories/postgres_session_repository.dart'
    as _i674;
import 'package:backend/src/features/auth/login/password/data/repositories/postgres_user_repository.dart'
    as _i374;
import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart'
    as _i754;
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart'
    as _i361;
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart'
    as _i599;
import 'package:backend/src/features/auth/login/request/data/repositories/request_login_repository.dart'
    as _i701;
import 'package:backend/src/features/auth/login/request/domain/repositories/i_request_login_repository.dart'
    as _i820;
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart'
    as _i359;
import 'package:backend/src/features/auth/login/shared/domain/use_cases/create_session_token_use_case.dart'
    as _i1050;
import 'package:backend/src/features/auth/login/verify/data/repositories/verify_login_email_repository.dart'
    as _i919;
import 'package:backend/src/features/auth/login/verify/domain/repositories/i_verify_login_email_repository.dart'
    as _i672;
import 'package:backend/src/features/auth/login/verify/domain/use_cases/verify_login_email_use_case.dart'
    as _i809;
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_all_use_case.dart'
    as _i151;
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_use_case.dart'
    as _i281;
import 'package:backend/src/features/auth/me/domain/use_cases/get_current_user_use_case.dart'
    as _i64;
import 'package:backend/src/features/auth/register/complete_profile/data/repositories/complete_profile_repository.dart'
    as _i994;
import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart'
    as _i310;
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart'
    as _i717;
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/validate_complete_profile_input_use_case.dart'
    as _i965;
import 'package:backend/src/features/auth/register/shared/domain/policies/registration_policies.dart'
    as _i443;
import 'package:backend/src/features/auth/register/start/data/repository/postgres_pending_registration_repository.dart'
    as _i214;
import 'package:backend/src/features/auth/register/start/domain/repository/i_pending_registration_repository.dart'
    as _i449;
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
import 'package:backend/src/features/auth/shared/domain/services/password_hasher.dart'
    as _i921;
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart'
    as _i375;
import 'package:backend/src/features/auth/shared/services/dev_email_sender.dart'
    as _i458;
import 'package:backend/src/features/auth/shared/services/email_code.dart'
    as _i298;
import 'package:backend/src/features/auth/shared/services/email_code_sender.dart'
    as _i155;
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
    gh.lazySingleton<_i155.EmailCodeSenderService>(
      () => _i458.DevEmailSender(gh<_i993.Talker>()),
    );
    gh.lazySingleton<_i375.SessionToken>(() => _i375.OpaqueBearerToken());
    gh.lazySingleton<_i443.UsernamePolicy>(
      () => const _i443.BlacklistUsernamePolicy(),
    );
    gh.lazySingleton<_i443.DisplayNamePolicy>(
      () => const _i443.ReservedDisplayNamePolicy(),
    );
    gh.lazySingleton<_i965.IValidateCompleteProfileInputUseCase>(
      () => _i965.ValidateCompleteProfileInputUseCase(
        gh<_i443.UsernamePolicy>(),
        gh<_i443.DisplayNamePolicy>(),
      ),
    );
    gh.lazySingleton<_i443.LoginPolicy>(
      () => const _i443.BlacklistLoginPolicy(),
    );
    gh.lazySingleton<_i443.EmailPolicy>(
      () => const _i443.BlocklistEmailPolicy(),
    );
    gh.lazySingleton<_i921.PasswordHasher>(
      () => const _i921.Argon2idPasswordHasher(),
    );
    gh.lazySingleton<_i476.IStartRegistrationValidateUseCase>(
      () => _i476.StartRegistrationValidateUseCase(
        gh<_i443.LoginPolicy>(),
        gh<_i443.EmailPolicy>(),
      ),
    );
    gh.lazySingleton<_i361.IUserRepository>(
      () => _i374.PostgresUserRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i820.IRequestLoginRepository>(
      () => _i701.RequestLoginRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i359.IVerifyEmailRegistrationRepository>(
      () => _i1058.VerifyEmailRegistrationRepository(
        gh<_i103.Pool<_i103.Connection>>(),
      ),
    );
    gh.lazySingleton<_i672.IVerifyLoginEmailRepository>(
      () =>
          _i919.VerifyLoginEmailRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i310.ICompleteProfileRepository>(
      () => _i994.CompleteProfileRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i754.ISessionRepository>(
      () => _i674.PostgresSessionRepository(gh<_i103.Pool<_i103.Connection>>()),
    );
    gh.lazySingleton<_i298.EmailCodeService>(
      () => _i298.EmailCodeServiceImpl(gh<_i921.PasswordHasher>()),
    );
    gh.lazySingleton<_i449.IPendingRegistrationRepository>(
      () => _i214.PostgresPendingRegistrationRepository(
        gh<_i103.Pool<_i103.Connection>>(),
      ),
    );
    gh.lazySingleton<_i1050.ICreateSessionTokenUseCase>(
      () => _i1050.CreateSessionTokenUseCase(
        gh<_i375.SessionToken>(),
        gh<_i754.ISessionRepository>(),
        gh<_i361.IUserRepository>(),
      ),
    );
    gh.lazySingleton<_i64.IGetCurrentUserUseCase>(
      () => _i64.GetCurrentUserUseCase(gh<_i361.IUserRepository>()),
    );
    gh.lazySingleton<_i151.ILogoutAllUseCase>(
      () => _i151.LogoutAllUseCase(gh<_i754.ISessionRepository>()),
    );
    gh.lazySingleton<_i281.ILogoutUseCase>(
      () => _i281.LogoutUseCase(
        gh<_i375.SessionToken>(),
        gh<_i754.ISessionRepository>(),
      ),
    );
    gh.lazySingleton<_i136.IVerifyRegistrationEmailUseCase>(
      () => _i136.VerifyRegistrationEmailUseCase(
        gh<_i359.IVerifyEmailRegistrationRepository>(),
        gh<_i298.EmailCodeService>(),
      ),
    );
    gh.lazySingleton<_i517.IStartRegistrationUseCase>(
      () => _i517.StartRegistrationUseCase(
        gh<_i476.IStartRegistrationValidateUseCase>(),
        gh<_i921.PasswordHasher>(),
        gh<_i298.EmailCodeService>(),
        gh<_i449.IPendingRegistrationRepository>(),
        gh<_i155.EmailCodeSenderService>(),
      ),
    );
    gh.lazySingleton<_i599.ILoginPasswordUseCase>(
      () => _i599.LoginPasswordUseCase(
        gh<_i361.IUserRepository>(),
        gh<_i921.PasswordHasher>(),
        gh<_i1050.ICreateSessionTokenUseCase>(),
      ),
    );
    gh.lazySingleton<_i717.ICompleteRegistrationProfileUseCase>(
      () => _i717.CompleteRegistrationProfileUseCase(
        gh<_i310.ICompleteProfileRepository>(),
        gh<_i361.IUserRepository>(),
        gh<_i965.IValidateCompleteProfileInputUseCase>(),
      ),
    );
    gh.lazySingleton<_i359.IRequestLoginUseCase>(
      () => _i359.RequestLoginUseCase(
        gh<_i361.IUserRepository>(),
        gh<_i298.EmailCodeService>(),
        gh<_i820.IRequestLoginRepository>(),
        gh<_i155.EmailCodeSenderService>(),
      ),
    );
    gh.lazySingleton<_i809.IVerifyLoginEmailUseCase>(
      () => _i809.VerifyLoginEmailUseCase(
        gh<_i361.IUserRepository>(),
        gh<_i672.IVerifyLoginEmailRepository>(),
        gh<_i298.EmailCodeService>(),
        gh<_i1050.ICreateSessionTokenUseCase>(),
      ),
    );
    gh.lazySingleton<_i48.AuthApi>(
      () => _i48.AuthApi(
        gh<_i64.IGetCurrentUserUseCase>(),
        gh<_i599.ILoginPasswordUseCase>(),
        gh<_i359.IRequestLoginUseCase>(),
        gh<_i809.IVerifyLoginEmailUseCase>(),
        gh<_i517.IStartRegistrationUseCase>(),
        gh<_i136.IVerifyRegistrationEmailUseCase>(),
        gh<_i717.ICompleteRegistrationProfileUseCase>(),
        gh<_i281.ILogoutUseCase>(),
        gh<_i151.ILogoutAllUseCase>(),
      ),
    );
    gh.lazySingleton<_i371.AppModule>(
      () => _i371.AppModule(gh<_i278.Router>(), gh<_i48.AuthApi>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i148.RegisterModule {}
