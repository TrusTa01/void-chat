import 'package:dio/dio.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';
import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';

mixin RegisterApiRequestHandler {
  Future<E> safeApiCall<T, E>({
    required Future<T> Function() request,
    E Function(T dto)? mapper,
  }) async {
    try {
      final response = await request.call();
      if (mapper != null) return mapper(response);
      return null as E;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Exception _handleDioError(DioException error) {
    final api = error.error;
    if (api is ApiException) {
      switch (api.code) {
        case 'EMAIL_TAKEN':
          throw const EmailTakenFailure();
        case 'USERNAME_TAKEN':
          throw const UsernameTakenFailure();
        case 'INVALID_REGISTRATION':
          throw const InvalidRegistrationFailure();
        case 'EMAIL_NOT_VERIFIED':
          throw const EmailNotVerifiedFailure();
        case 'INVALID_EMAIL_CODE':
          throw const RegisterEmailCodeFailure(RegisterEmailCodeError.invalid);
        case 'EMAIL_CODE_EXPIRED':
          throw const RegisterEmailCodeFailure(RegisterEmailCodeError.expired);
        case 'EMAIL_CODE_ATTEMPTS_EXCEEDED':
          throw const RegisterEmailCodeFailure(
            RegisterEmailCodeError.attemptsExceeded,
          );
        case 'EMAIL_CODE_RESEND_TOO_SOON':
          throw const RegisterResendTooSoonFailure();
        case 'INVALID_CREDENTIALS':
        case 'UNAUTHORIZED':
          throw const RegisterEmailCodeFailure(RegisterEmailCodeError.invalid);
        default:
          throw UnknownRegisterFailure(api.message);
      }
    }
    throw const RegisterNetworkFailure();
  }
}
