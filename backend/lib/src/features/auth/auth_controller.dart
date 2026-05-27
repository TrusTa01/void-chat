import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/features/auth/login/password/api/dto/request/login_request_dto.dart';
import 'package:backend/src/features/auth/login/password/api/mappers/logged_in_user_dto_mapper.dart';
import 'package:backend/src/features/auth/login/password/api/mappers/login_response_mapper.dart';
import 'package:backend/src/features/auth/login/request/api/dto/login_code_request_dto.dart';
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart';
import 'package:backend/src/features/auth/login/verify/api/dto/login_code_verify_dto.dart';
import 'package:backend/src/features/auth/login/verify/domain/use_cases/verify_login_email_use_case.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_all_use_case.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_use_case.dart';
import 'package:backend/src/features/auth/me/domain/use_cases/get_current_user_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/api/mappers/start_registration_response_mapper.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/cancel/api/dto/cancel_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/cancel/domain/use_cases/cancel_registration_use_case.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:backend/src/features/auth/shared/verify-email/api/dto/request/verify_code_request_dto.dart';
import 'package:backend/src/features/auth/shared/verify-email/api/dto/response/verify_email_response_dto.dart';
import 'package:backend/src/core/api/parse_body.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/mappers/register_response_mapper.dart';
import 'package:backend/src/middleware/auth_middleware.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  // me
  final IGetCurrentUserUseCase _getCurrentUserUseCase;

  // login
  final ILoginPasswordUseCase _loginPassUseCase;
  final IRequestLoginUseCase _requestLoginUseCase;
  final IVerifyLoginEmailUseCase _verifyLoginEmailUseCase;

  // register
  final IStartRegistrationUseCase _startRegistrationUseCase;
  final IVerifyRegistrationEmailUseCase _verifyRegistrationEmailUseCase;
  final ICompleteRegistrationProfileUseCase _completeRegisterUseCase;
  final ICancelRegistrationUseCase _cancelRegistrationUseCase;

  // logout
  final ILogoutUseCase _logoutUseCase;
  final ILogoutAllUseCase _logoutAllUseCase;

  AuthApi(
    this._getCurrentUserUseCase,
    this._loginPassUseCase,
    this._requestLoginUseCase,
    this._verifyLoginEmailUseCase,
    this._startRegistrationUseCase,
    this._verifyRegistrationEmailUseCase,
    this._completeRegisterUseCase,
    this._cancelRegistrationUseCase,
    this._logoutUseCase,
    this._logoutAllUseCase,
  );

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    // ------------------------ me ------------------------
    r.get('/me', _meHandler);

    // ------------------------ login ------------------------
    r.post(
      '/login/password',
      (Request request) => _loginPasswordHandler(request),
    );
    r.post(
      '/login/code/request',
      (Request request) => _loginRequestHandler(request),
    );
    r.post(
      '/login/code/verify',
      (Request request) => _loginVerifyHandler(request),
    );

    // ------------------------ register ------------------------
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
    r.post(
      '/register/cancel',
      (Request request) => _cancelRegistrationHandler(request),
    );

    // ------------------------ logout ------------------------
    r.post('/logout', (Request request) => _logoutHandler(request));
    r.post('/logout/all', (Request request) => _logoutAllHandler(request));
    return r;
  }

  // ------------------------ me ------------------------
  Future<Response> _meHandler(Request request) async {
    final userId = request.context[authenticatedUserIdKey] as String;
    final user = await _getCurrentUserUseCase.call(userId);
    return JsonResponse.ok(user.toLoggedInUserDto().toJson());
  }

  // ------------------------ login ------------------------
  Future<Response> _loginPasswordHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginRequestDto.fromJson);
    final result = await _loginPassUseCase.call(dto.identifier, dto.password);
    final response = result.toResponse();
    return JsonResponse.ok(response.toJson());
  }

  Future<Response> _loginRequestHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginCodeRequestDto.fromJson);
    await _requestLoginUseCase.send(dto.identifier);
    return JsonResponse.ok({'sent': true});
  }

  Future<Response> _loginVerifyHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, LoginCodeVerifyDto.fromJson);
    final result = await _verifyLoginEmailUseCase.verify(
      identifier: dto.identifier,
      code: dto.code,
    );
    final response = result.toResponse();
    return JsonResponse.ok(response.toJson());
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
    final dto = parseBody(body, CodeVerifyRequestDto.fromJson);
    await _verifyRegistrationEmailUseCase.call(
      registrationId: dto.registrationId,

      code: dto.code,
    );
    return JsonResponse.ok(VerifyEmailResponseDto(verified: true));
  }

  Future<Response> _registerCompleteProfileHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, CompleteProfileRequestDto.fromJson);
    final user = await _completeRegisterUseCase.call(dto);
    final response = user.toResponse();
    return JsonResponse.created(response.toJson());
  }

  Future<Response> _cancelRegistrationHandler(Request request) async {
    final body = await request.readAsString();
    final dto = parseBody(body, CancelRegistrationRequestDto.fromJson);
    await _cancelRegistrationUseCase.call(dto.registrationId);
    return JsonResponse.ok({'cancelled': true});
  }

  // ------------------------ logout ------------------------
  Future<Response> _logoutHandler(Request request) async {
    final token = extractBearerToken(request)!;
    await _logoutUseCase.call(token);
    return JsonResponse.ok({'ok': true});
  }

  Future<Response> _logoutAllHandler(Request request) async {
    final userId = request.context[authenticatedUserIdKey] as String;
    await _logoutAllUseCase.call(userId);
    return JsonResponse.ok({'ok': true});
  }
}
