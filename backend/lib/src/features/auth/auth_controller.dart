import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/features/auth/login/password/api/dto/request/login_request_dto.dart';
import 'package:backend/src/features/auth/login/password/api/mappers/login_response_mapper.dart';
import 'package:backend/src/features/auth/login/request/api/dto/login_code_request_dto.dart';
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/api/mappers/start_registration_response_mapper.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/verify_email/api/dto/request/verify_registration_email_request_dto.dart';
import 'package:backend/src/features/auth/register/verify_email/api/dto/response/verify_registration_email_response_dto.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:backend/src/features/auth/shared/api/mappers/parse_body.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/mappers/register_response_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  final ILoginPasswordUseCase _loginPasswordUseCase;
  final ICompleteRegistrationProfileUseCase _completeRegisterUseCase;
  final IStartRegistrationUseCase _startRegistrationUseCase;
  final IVerifyRegistrationEmailUseCase _emailVerifyUseCase;
  final IRequestLoginUseCase _requestLoginUseCase;

  AuthApi(
    this._loginPasswordUseCase,
    this._completeRegisterUseCase,
    this._startRegistrationUseCase,
    this._emailVerifyUseCase,
    this._requestLoginUseCase,
  );

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    // login
    r.post(
      '/login-password',
      (Request request) => _loginPasswordHandler(request),
    );
    r.post(
      '/login/code/request',
      (Request request) => _loginRequestHandler(request),
    );
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
      (Request request) => _registerCompleteProfileHandler(request),
    );

    return r;
  }

  // ------------------------ login ------------------------
  Future<Response> _loginPasswordHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginRequestDto.fromJson);
    final result = await _loginPasswordUseCase.call(
      dto.identifier,
      dto.password,
    );
    final response = result.toLoginResponse();
    return JsonResponse.ok(response.toJson());
  }

  Future<Response> _loginRequestHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginCodeRequestDto.fromJson);
    await _requestLoginUseCase.send(dto.identifier);
    return JsonResponse.ok({'sent': true});
  }

  // ------------------------ register ------------------------
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

  Future<Response> _registerCompleteProfileHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, CompleteProfileRequestDto.fromJson);
    final user = await _completeRegisterUseCase.call(dto);
    final response = user.toResponse();
    return JsonResponse.created(response.toJson());
  }
}
