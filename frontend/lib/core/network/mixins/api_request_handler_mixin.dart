import 'package:dio/dio.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';

mixin ApiRequestHandler {
  Future<E> safeApiCall<T, E>({
    required Future<T> Function() request,
    Future<void> Function(T dto)? onSave,
    E Function(T dto)? mapper,
  }) async {
    try {
      final response = await request.call();
      await onSave?.call(response);

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
        case 'INVALID_CREDENTIALS':
          throw const InvalidCredentialsFailure();
        case 'INVALID_EMAIL_CODE':
          throw const EmailCodeFailure(EmailCodeError.invalid);
        case 'EMAIL_CODE_EXPIRED':
          throw const EmailCodeFailure(EmailCodeError.expired);
        case 'EMAIL_CODE_ATTEMPTS_EXCEEDED':
          throw const EmailCodeFailure(EmailCodeError.attemptsExceeded);
        case 'EMAIL_CODE_RESEND_TOO_SOON':
          throw const ResendTooSoonFailure();
        case 'UNAUTHORIZED':
          throw const InvalidCredentialsFailure();
        default:
          throw UnknownLoginFailure(api.message);
      }
    }
    throw const NetworkFailure();
  }
}
