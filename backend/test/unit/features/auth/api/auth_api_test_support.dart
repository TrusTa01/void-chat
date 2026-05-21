import 'dart:convert';

import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/auth/login/password/domain/usecases/login_password_use_case.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/login/request/domain/use_cases/request_login_use_case.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/usecases/verify_email_use_case.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_all_use_case.dart';
import 'package:backend/src/features/auth/logout/domain/use_cases/logout_use_case.dart';
import 'package:backend/src/features/auth/me/domain/use_cases/get_current_user_use_case.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/register_user_use_case.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/middleware/auth_middleware.dart';
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

Request authorizedGet(
  String path, {
  required String userId,
  String token = 'test-token',
}) {
  return Request(
    'GET',
    Uri.parse('http://localhost$path'),
    headers: {'Authorization': 'Bearer $token'},
  ).change(context: {authenticatedUserIdKey: userId});
}

Request authorizedPost(
  String path, {
  required String userId,
  String token = 'test-token',
}) {
  return Request(
    'POST',
    Uri.parse('http://localhost$path'),
    headers: {'Authorization': 'Bearer $token'},
  ).change(context: {authenticatedUserIdKey: userId});
}

Future<Map<String, dynamic>> decodeBody(Response response) async {
  return jsonDecode(await response.readAsString()) as Map<String, dynamic>;
}

AuthApi buildTestAuthApi({
  IGetCurrentUserUseCase? getCurrentUser,
  ILoginPasswordUseCase? loginPassword,
  IRequestLoginUseCase? requestLogin,
  IVerifyEmailUseCase? verifyEmail,
  IStartRegistrationUseCase? startRegistration,
  ICompleteRegistrationProfileUseCase? completeProfile,
  ILogoutUseCase? logout,
  ILogoutAllUseCase? logoutAll,
}) {
  return AuthApi(
    getCurrentUser ?? UnusedGetCurrentUserUseCase(),
    loginPassword ?? UnusedLoginPasswordUseCase(),
    requestLogin ?? UnusedRequestLoginUseCase(),
    verifyEmail ?? UnusedVerifyEmailUseCase(),
    startRegistration ?? UnusedStartRegistrationUseCase(),
    completeProfile ?? UnusedCompleteRegistrationProfileUseCase(),
    logout ?? UnusedLogoutUseCase(),
    logoutAll ?? UnusedLogoutAllUseCase(),
  );
}

final class UnusedGetCurrentUserUseCase implements IGetCurrentUserUseCase {
  @override
  Future<UserEntity> call(String userId) {
    throw StateError('IGetCurrentUserUseCase should not be called');
  }
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

final class UnusedVerifyEmailUseCase implements IVerifyEmailUseCase {
  @override
  Future<LoginResult> verify({
    required String identifier,
    required String code,
  }) {
    throw StateError('IVerifyEmailUseCase should not be called');
  }
}

final class UnusedStartRegistrationUseCase
    implements IStartRegistrationUseCase {
  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) {
    throw StateError('IStartRegistrationUseCase should not be called');
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

final class UnusedLogoutUseCase implements ILogoutUseCase {
  @override
  Future<void> call(String accessToken) {
    throw StateError('ILogoutUseCase should not be called');
  }
}

final class UnusedLogoutAllUseCase implements ILogoutAllUseCase {
  @override
  Future<void> call(String userId) {
    throw StateError('ILogoutAllUseCase should not be called');
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
