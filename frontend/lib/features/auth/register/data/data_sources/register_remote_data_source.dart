import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/register/data/models/start/start_registration_response_dto.dart';
import 'package:void_chat/features/auth/register/data/models/verify/verify_email_response_dto.dart';
import 'package:void_chat/features/auth/shared/data/auth_api_path_enum.dart';
import 'package:void_chat/features/auth/shared/data/models/user/user_dto.dart';

@lazySingleton
class RegisterRemoteDataSource {
  final Dio _dio;

  const RegisterRemoteDataSource(this._dio);

  Future<StartRegistrationResponseDto> start({
    required String login,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      AuthApiPathEnum.registerStart.path,
      data: {'login': login, 'email': email, 'password': password},
    );
    return StartRegistrationResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<VerifyEmailResponseDto> verifyEmail({
    required String registrationId,
    required String code,
  }) async {
    final response = await _dio.post(
      AuthApiPathEnum.registerVerify.path,
      data: {'registration_id': registrationId, 'code': code},
    );
    return VerifyEmailResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<void> cancelRegistration({required String registrationId}) => _dio.post(
    AuthApiPathEnum.registerCancel.path,
    data: {'registration_id': registrationId},
  );

  Future<UserDto> completeProfile({
    required String registrationId,
    required String username,
    required String displayName,
  }) async {
    final response = await _dio.post(
      AuthApiPathEnum.registerProfile.path,
      data: {
        'registration_id': registrationId,
        'username': username,
        'display_name': displayName,
      },
    );
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }
}
