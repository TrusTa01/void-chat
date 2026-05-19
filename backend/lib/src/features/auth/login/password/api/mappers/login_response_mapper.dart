import 'package:backend/src/features/auth/login/password/api/dto/response/login_response_dto.dart';
import 'package:backend/src/features/auth/login/password/api/mappers/logged_in_user_dto_mapper.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';

extension LoginResponseMapper on LoginResult {
  LoginResponseDto toLoginResponse() => LoginResponseDto(
    accessToken: token,
    user: user.toLoggedInUserDto(),
    expiresIn: Ttl.sessionTtlD30.inSeconds,
  );
}
