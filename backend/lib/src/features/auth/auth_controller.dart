import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/features/auth/login/api/dto/request/login_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/register_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/mappers/register_request_mapper.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/api/mappers/start_registration_response_mapper.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/verify_email/api/dto/request/verify_registration_email_request_dto.dart';
import 'package:backend/src/features/auth/register/verify_email/api/dto/response/verify_registration_email_response_dto.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:backend/src/features/auth/shared/mappers/parse_body.dart';
import 'package:backend/src/features/auth/login/api/mappers/login_response_mapper.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/mappers/register_response_mapper.dart';
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/src/features/auth/domain/usecases/login_user.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  final ILoginUser _loginUser;
  final IRegisterUser _registerUserUseCase;
  final IStartRegistrationUseCase _startRegistrationUseCase;
  final IVerifyRegistrationEmailUseCase _emailVerifyUseCase;

  AuthApi(
    this._loginUser,
    this._registerUserUseCase,
    this._startRegistrationUseCase,
    this._emailVerifyUseCase,
  );

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    // login
    r.post('/login', (Request request) => _loginHandler(request));
    r.post('/login/code/request', (Request request) => Response.ok);
    r.post('/login/code/verify', (Request request) => Response.ok);

    // register
    r.post(
      '/register/start',
      (Request request) => _startRegistrationHandler(request),
    );
    r.post(
      '/register/verify-email',
      (Request request) => _verifyEmailRegistrationHandler(request),
    );
    r.post(
      '/register/complete-profile',
      (Request request) => _registerHandler(request),
    );

    return r;
  }

  Future<Response> _loginHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginRequestDto.fromJson);
    final result = await _loginUser.call(dto.identifier, dto.password);
    final response = result.toLoginResponse();
    return JsonResponse.ok(response.toJson());
  }

  Future<Response> _startRegistrationHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, StartRegistrationRequestDto.fromJson);
    final result = await _startRegistrationUseCase.call(dto);
    final response = result.toResponse();
    return JsonResponse.created(response.toJson());
  }

  Future<Response> _verifyEmailRegistrationHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, VerifyRegistrationEmailRequestDto.fromJson);
    await _emailVerifyUseCase.call(
      registrationId: dto.registrationId,
      code: dto.code,
    );
    return JsonResponse.ok(VerifyRegistrationEmailResponseDto(verified: true));
  }

  Future<Response> _registerHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, RegisterRequestDto.fromJson);
    final result = await _registerUserUseCase.call(dto.toNewUser());
    final response = result.toRegisterResponse();
    return JsonResponse.created(response.toJson());
  }
}
