import 'package:dio/dio.dart';
import 'package:void_chat/core/auth/infrastructure/i_session_expired_handler.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  final ISessionExpiredHandler _sessionExpired;

  const ErrorInterceptor(this._sessionExpired);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiException = _tryParseApiException(err);

    if (apiException != null) {
      if (err.response?.statusCode == 401) {
        _sessionExpired.onSessionExpired();
      }

      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: apiException,
        ),
      );
      return;
    }

    handler.next(err);
  }

  ApiException? _tryParseApiException(DioException err) {
    final data = err.response?.data;
    if (data is! Map<String, dynamic>) return null;
    if (data['success'] != false) return null;

    final error = data['error'];
    if (error is! Map<String, dynamic>) return null;

    final code = error['code'];
    final message = error['message'];
    if (code is! String || message is! String) return null;

    List<ApiFieldError>? details;
    final rawDetails = error['details'];
    if (rawDetails is List) {
      details = rawDetails
          .whereType<Map<String, dynamic>>()
          .map(ApiFieldError.fromJson)
          .toList();
    }

    return ApiException(
      code: code,
      message: message,
      statusCode: err.response?.statusCode,
      details: details,
    );
  }
}
