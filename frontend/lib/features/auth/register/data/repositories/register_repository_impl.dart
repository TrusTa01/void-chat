import 'package:injectable/injectable.dart';
import 'package:void_chat/core/data/base_repository.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';
import 'package:void_chat/features/auth/login/data/mappers/user_entity_mapper.dart';
import 'package:void_chat/features/auth/register/data/data_sources/register_remote_data_source.dart';
import 'package:void_chat/features/auth/register/data/models/start/start_registration_response_dto.dart';
import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';
import 'package:void_chat/features/auth/register/domain/repositories/i_register_repository.dart';
import 'package:void_chat/features/auth/shared/data/models/user/user_dto.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

@LazySingleton(as: IRegisterRepository)
class RegisterRepositoryImpl
    extends BaseRepository<RegisterFailure>
    implements IRegisterRepository {
  final RegisterRemoteDataSource _dataSource;

  const RegisterRepositoryImpl(this._dataSource);

  @override
  Future<String> startRegistration({
    required String login,
    required String email,
    required String password,
  }) => safeApiCall<StartRegistrationResponseDto, String>(
    request: () =>
        _dataSource.start(login: login, email: email, password: password),
    mapper: (dto) => dto.registrationId,
  );

  @override
  Future<void> verifyRegistrationEmail({
    required String registrationId,
    required String code,
  }) => safeApiCall(
    request: () =>
        _dataSource.verifyEmail(registrationId: registrationId, code: code),
  );

  @override
  Future<void> cancelRegistration({required String registrationId}) =>
      safeApiCall(
        request: () =>
            _dataSource.cancelRegistration(registrationId: registrationId),
      );

  @override
  Future<UserEntity> completeRegistration({
    required String registrationId,
    required String username,
    required String displayName,
  }) => safeApiCall<UserDto, UserEntity>(
    request: () => _dataSource.completeProfile(
      registrationId: registrationId,
      username: username,
      displayName: displayName,
    ),
    mapper: (dto) => dto.toEntity(),
  );

  @override
  RegisterFailure mapApiError(ApiException e) => switch (e.code) {
    'EMAIL_TAKEN' => const EmailTakenFailure(),
    'USERNAME_TAKEN' => const UsernameTakenFailure(),
    'INVALID_REGISTRATION' => const InvalidRegistrationFailure(),
    'EMAIL_NOT_VERIFIED' => const EmailNotVerifiedFailure(),
    'INVALID_EMAIL_CODE' =>
      const RegisterEmailCodeFailure(RegisterEmailCodeError.invalid),
    'EMAIL_CODE_EXPIRED' =>
      const RegisterEmailCodeFailure(RegisterEmailCodeError.expired),
    'EMAIL_CODE_ATTEMPTS_EXCEEDED' =>
      const RegisterEmailCodeFailure(RegisterEmailCodeError.attemptsExceeded),
    'EMAIL_CODE_RESEND_TOO_SOON' => const RegisterResendTooSoonFailure(),
    _ => UnknownRegisterFailure(e.message),
  };

  @override
  RegisterFailure get networkError => const RegisterNetworkFailure();
}
