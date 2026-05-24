import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:void_chat/core/auth/infrastructure/i_session_expired_handler.dart';
import 'package:void_chat/core/network/api_config.dart';
import 'package:void_chat/core/network/interceptors/auth_interceptor.dart';
import 'package:void_chat/core/network/interceptors/error_interceptor.dart';
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart';

@lazySingleton
class DioClient extends DioMixin implements Dio {
  final Talker _talker;
  final AppSecureStorage _storage;
  final ISessionExpiredHandler _sessionExpired;

  DioClient(this._talker, this._storage, this._sessionExpired) {
    options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
    );

    httpClientAdapter = IOHttpClientAdapter();

    interceptors.addAll([
      TalkerDioLogger(talker: _talker),
      AuthInterceptor(_storage),
      ErrorInterceptor(_sessionExpired),
    ]);
  }
}
