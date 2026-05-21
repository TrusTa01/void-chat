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

  Future<void> loginCodeRequest({required String identifier}) => _dio.post(
    AuthApiPathEnum.loginCodeReq.path,
    data: {'identifier': identifier},
  );

  Future<LoginResponseDto> loginCodeVerify({
    required String identifier,
    required String code,
  }) async {
    final response = await _dio.post(
      AuthApiPathEnum.loginCodeVerify.path,
      data: {'identifier': identifier, 'code': code},
    );
    return LoginResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
