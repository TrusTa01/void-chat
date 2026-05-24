import 'package:dio/dio.dart';
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  final AppSecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
