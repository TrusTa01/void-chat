import 'package:backend/src/features/auth/login/api/dto/response/login_response_dto.dart';
import 'package:backend/src/features/auth/login/api/mappers/logged_in_user_dto_mapper.dart';
import 'package:backend/src/features/auth/login/ttl.dart';
import 'package:backend/src/features/auth/shared/domain/value_objects/login_result.dart';

extension LoginResponseMapper on LoginResult {
  LoginResponseDto toLoginResponse() => LoginResponseDto(
    accessToken: token,
    user: user.toLoggedInUserDto(),
    expiresIn: Ttl.sessionTtlD30.inSeconds,
  );
}
