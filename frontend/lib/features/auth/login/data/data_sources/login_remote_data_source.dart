import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/data/models/login_response_dto.dart';
import 'package:void_chat/features/auth/shared/data/auth_api_path_enum.dart';

@lazySingleton
class LoginRemoteDataSource {
  final Dio _dio;

  const LoginRemoteDataSource(this._dio);

  Future<LoginResponseDto> loginWithPassword({
    required String identifier,
    required String password,
  }) async {
    final response = await _dio.post(
      AuthApiPathEnum.loginPass.path,
      data: {'identifier': identifier, 'password': password},
    );
    return LoginResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
