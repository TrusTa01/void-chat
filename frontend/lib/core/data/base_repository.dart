import 'package:dio/dio.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';

abstract class BaseRepository<F extends Object> {
  const BaseRepository();

  F mapApiError(ApiException e);
  F get networkError;

  Future<R> safeApiCall<T, R>({
    required Future<T> Function() request,
    R Function(T)? mapper,
    Future<void> Function(T)? onSave,
  }) async {
    try {
      final response = await request();

      await onSave?.call(response);
      if (mapper != null) return mapper(response);

      return null as R;
    } on DioException catch (e) {
      final api = e.error;
      if (api is ApiException) throw mapApiError(api);
      throw networkError;
    }
  }
}
