import 'dart:convert';

import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/features/auth/api/auth_api.dart';
import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

class FakeRegisterUser implements IRegisterUser {
  NewUser? capturedInput;

  @override
  Future<UserEntity> call(NewUser data) async {
    capturedInput = data;

    return UserEntity(
      id: 1,
      email: data.email,
      username: data.username,
      displayName: data.displayName,
      createdAt: DateTime.parse('2026-01-01T00:00:00Z'),
    );
  }
}

void main() {
  group('AuthApi POST /register', () {
    late FakeRegisterUser fakeUseCase;
    late AuthApi api;

    Request buildRequest(String body) => Request(
      'POST',
      Uri.parse('http://localhost/register'),
      headers: {'content-type': 'application/json'},
      body: body,
    );

    setUp(() {
      fakeUseCase = FakeRegisterUser();
      api = AuthApi(fakeUseCase);
    });

    test('valid payload -> 201', () async {
      // Arrange
      final requestBody = jsonEncode({
        'login': 'john_login',
        'password': 'secret123',
        'email': 'john@email.com',
        'username': 'johnny',
        'display_name': 'John',
      });
      final request = buildRequest(requestBody);
      final response = await api.router.call(request);
      final rawBody = await response.readAsString();
      final json = jsonDecode(rawBody) as Map<String, dynamic>;

      // Assert: status
      expect(response.statusCode, 201);

      // Assert: use case got mapped input
      expect(fakeUseCase.capturedInput, isNotNull);
      expect(fakeUseCase.capturedInput!.login, 'john_login');
      expect(fakeUseCase.capturedInput!.displayName, 'John');

      // Assert: response body shape
      expect(json['id'], 1);
      expect(json['email'], 'john@email.com');
      expect(json['username'], 'johnny');
      expect(json['display_name'], 'John');
      expect(json['created_at'], isA<String>());
    });

    test('invalid payload -> validation exception', () async {
      // Arrange
      final requestBody = jsonEncode({
        'login': 0,
        'password': 'secret123',
        'email': ['1', 2],
        'username': 'johnny',
        'display_name': 'John',
      });
      final request = buildRequest(requestBody);

      // Assert: status
      expect(
        () => api.router.call(request),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
