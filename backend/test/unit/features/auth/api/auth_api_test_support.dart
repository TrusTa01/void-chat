import 'dart:convert';

import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart';
import 'package:backend/src/features/auth/login/verify/domain/use_cases/verify_login_email_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/use_cases/verify_registration_email_use_case.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/middleware/error_middleware.dart';
import 'package:shelf/shelf.dart';

Handler createAuthHandler(AuthApi api) {
  return const Pipeline()
      .addMiddleware(errorMiddleware())
      .addHandler(api.router.call);
}

Request jsonPost(String path, Map<String, Object?> body) {
  return Request(
    'POST',
    Uri.parse('http://localhost$path'),
    body: jsonEncode(body),
    headers: {'content-type': 'application/json'},
  );
}

Future<Map<String, dynamic>> decodeBody(Response response) async {
  return jsonDecode(await response.readAsString()) as Map<String, dynamic>;
}

AuthApi buildTestAuthApi({
  ILoginPasswordUseCase? loginPassword,
  IRequestLoginUseCase? requestLogin,
  IVerifyLoginEmailUseCase? verifyLoginEmail,
  IStartRegistrationUseCase? startRegistration,
  IVerifyRegistrationEmailUseCase? verifyRegistrationEmail,
  ICompleteRegistrationProfileUseCase? completeProfile,
}) {
  return AuthApi(
    loginPassword ?? UnusedLoginPasswordUseCase(),
    requestLogin ?? UnusedRequestLoginUseCase(),
    verifyLoginEmail ?? UnusedVerifyLoginEmailUseCase(),
    startRegistration ?? UnusedStartRegistrationUseCase(),
    verifyRegistrationEmail ?? UnusedVerifyRegistrationEmailUseCase(),
    completeProfile ?? UnusedCompleteRegistrationProfileUseCase(),
  );
}

final class UnusedLoginPasswordUseCase implements ILoginPasswordUseCase {
  @override
  Future<LoginResult> call(String identifier, String password) {
    throw StateError('ILoginPasswordUseCase should not be called');
  }
}

final class UnusedRequestLoginUseCase implements IRequestLoginUseCase {
  @override
  Future<void> send(String identifier) {
    throw StateError('IRequestLoginUseCase should not be called');
  }
}

final class UnusedVerifyLoginEmailUseCase implements IVerifyLoginEmailUseCase {
  @override
  Future<LoginResult> verify({
    required String identifier,
    required String code,
  }) {
    throw StateError('IVerifyLoginEmailUseCase should not be called');
  }
}

final class UnusedStartRegistrationUseCase
    implements IStartRegistrationUseCase {
  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) {
    throw StateError('IStartRegistrationUseCase should not be called');
  }
}

final class UnusedVerifyRegistrationEmailUseCase
    implements IVerifyRegistrationEmailUseCase {
  @override
  Future<void> call({required String registrationId, required String code}) {
    throw StateError('IVerifyRegistrationEmailUseCase should not be called');
  }
}

final class UnusedCompleteRegistrationProfileUseCase
    implements ICompleteRegistrationProfileUseCase {
  @override
  Future<UserEntity> call(CompleteProfileRequestDto data) {
    throw StateError(
      'ICompleteRegistrationProfileUseCase should not be called',
    );
  }
}

UserEntity sampleLoggedInUser() {
  return UserEntity(
    id: 'user-123',
    email: 'john@example.com',
    username: 'john_doe',
    displayName: 'John Doe',
    createdAt: DateTime.parse('2026-05-19T00:00:00.000Z'),
  );
}

LoginResult sampleLoginResult() {
  return LoginResult(token: 'session-token-abc', user: sampleLoggedInUser());
}
