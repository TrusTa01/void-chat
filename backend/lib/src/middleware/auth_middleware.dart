import 'package:backend/src/core/di/locator.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart';
import 'package:shelf/shelf.dart';

const authenticatedUserIdKey = 'authenticatedUserId';

Middleware authMiddleware() {
  return (Handler inner) {
    return (Request request) async {
      if (!_requiresAuth(request.url.path)) return inner(request);

      final userId = await _resolveUserId(request);
      if (userId == null) {
        throw const UnauthorizedException(
          AuthErrorCodes.unauthorized,
          'Missing or invalid access token',
        );
      }

      return inner(request.change(context: {authenticatedUserIdKey: userId}));
    };
  };
}

bool _requiresAuth(String path) {
  const publicPaths = {
    '/auth/register/start',
    '/auth/register/verify-email',
    '/auth/register/complete-profile',
    '/auth/login-password',
    '/auth/login/code/request',
    '/auth/login/code/verify',
  };
  return !publicPaths.contains(path);
}

Future<String?> _resolveUserId(Request request) async {
  final authHeader = request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) {
    return null;
  }

  final token = extractBearerToken(request);
  if (token == null) return null;

  final sessionToken = getIt<SessionToken>();
  final sessionRepo = getIt<ISessionRepository>();
  final tokenHash = sessionToken.hashSessionToken(token);

  return sessionRepo.findUserIdByTokenHash(tokenHash);
}

String? extractBearerToken(Request request) {
  final authHeader = request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) {
    return null;
  }
  final token = authHeader.substring('Bearer '.length).trim();
  return token.isEmpty ? null : token;
}
