import 'package:injectable/injectable.dart';
import 'package:void_chat/core/data/base_repository.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart';
import 'package:void_chat/features/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:void_chat/features/auth/login/data/mappers/user_entity_mapper.dart';
import 'package:void_chat/features/auth/login/data/models/login_response_dto.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepositoryImpl extends BaseRepository<LoginFailure>
    implements ILoginRepository {
  final LoginRemoteDataSource _dataSource;
  final AppSecureStorage _secureStorage;

  const LoginRepositoryImpl(this._dataSource, this._secureStorage);

  @override
  Future<UserEntity> loginWithPassword(String identifier, String password) =>
      safeApiCall<LoginResponseDto, UserEntity>(
        request: () => _dataSource.loginWithPassword(
          identifier: identifier,
          password: password,
        ),
        mapper: (dto) => dto.user.toEntity(),
        onSave: (dto) => _secureStorage.saveToken(dto.accessToken),
      );

  @override
  Future<void> loginWithCode(String identifier) => safeApiCall(
    request: () => _dataSource.loginCodeRequest(identifier: identifier),
  );

  @override
  Future<UserEntity> verifyLoginCode(String identifier, String code) =>
      safeApiCall<LoginResponseDto, UserEntity>(
        request: () =>
            _dataSource.loginCodeVerify(identifier: identifier, code: code),
        mapper: (dto) => dto.user.toEntity(),
        onSave: (dto) => _secureStorage.saveToken(dto.accessToken),
      );

  @override
  LoginFailure mapApiError(ApiException e) => switch (e.code) {
    'INVALID_CREDENTIALS' => const InvalidCredentialsFailure(),
    'INVALID_EMAIL_CODE' => const EmailCodeFailure(EmailCodeError.invalid),
    'EMAIL_CODE_EXPIRED' => const EmailCodeFailure(EmailCodeError.expired),
    'EMAIL_CODE_ATTEMPTS_EXCEEDED' => const EmailCodeFailure(
      EmailCodeError.attemptsExceeded,
    ),
    'EMAIL_CODE_RESEND_TOO_SOON' => const ResendTooSoonFailure(),
    'UNAUTHORIZED' => const InvalidCredentialsFailure(),
    _ => UnknownLoginFailure(e.message),
  };

  @override
  LoginFailure get networkError => const NetworkFailure();
}
