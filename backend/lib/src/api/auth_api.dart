import 'dart:convert';

import 'package:backend/core/di/locator.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    r.post('/login', (Request request) async => Response.ok('ok'));

    r.post('/register', (Request request) async => _registerHandler(request));

    return r;
  }

  Future<Response> _registerHandler(Request request) async {
    try {
      final body = await request.readAsString();
      final data = jsonDecode(body) as Map<String, dynamic>;

      final login = data['login'] as String;
      final password = data['password'] as String;
      final email = data['email'] as String;
      final username = data['username'] as String;
      final displayName = data['display_name'] as String;

      try {
        await pool.execute(
          '''
          INSERT INTO users (login, password_hash, email, username, display_name)
          VALUES (@login, @encrypted_password, @email, @username, @display_name)
          ''',
          parameters: {
            'login': login,
            'encrypted_password': password,
            'email': email,
            'username': username,
            'display_name': displayName,
          },
        );
        return Response.ok(body);
      } on ServerException catch (e) {
        if (e.code == '23505') {
          return Response.forbidden(
            jsonEncode({'error': 'Email already exists'}),
          );
        }
        rethrow;
      } catch (e) {
        talker.error('Registration error', e);
        return Response.internalServerError();
      }
    } catch (e) {
      return Response.badRequest(body: 'Ошибка в формате JSON: $e');
    }
  }
}
