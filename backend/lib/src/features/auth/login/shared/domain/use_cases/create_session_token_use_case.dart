import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICreateSessionTokenUseCase {
  Future<LoginResult> create(String userId);
}

@LazySingleton(as: ICreateSessionTokenUseCase)
class CreateSessionTokenUseCase implements ICreateSessionTokenUseCase {
  final SessionToken _token;
  final ISessionRepository _sessionRepo;
  final IUserRepository _userRepo;

  const CreateSessionTokenUseCase(
    this._token,
    this._sessionRepo,
    this._userRepo,
  );

  @override
  Future<LoginResult> create(String userId) async {
    final token = _token.generateSessionToken();
    final tokenHash = _token.hashSessionToken(token);
    final expiresAt = DateTime.now().toUtc().add(Ttl.sessionTtlD30);

    await _sessionRepo.create(userId, tokenHash, expiresAt);

    final user = await _userRepo.findById(userId);
    if (user == null) {
      throw const InternalServerException(
        'USER_GONE',
        'User row disappeared between auth and read',
      );
    }

    return LoginResult(token: token, user: user);
  }
}
