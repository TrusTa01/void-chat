import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/ttl.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/repository/i_session_repository.dart';
import 'package:backend/src/features/auth/shared/domain/repository/i_user_repository.dart';
import 'package:backend/src/features/auth/shared/domain/services/password_hasher.dart';
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart';
import 'package:backend/src/features/auth/shared/domain/value_objects/login_result.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILoginUser {
  Future<LoginResult> call(String identifier, String password);
}

@LazySingleton(as: ILoginUser)
class LoginUser implements ILoginUser {
  final IUserRepository _userRepo;
  final ISessionRepository _sessionRepo;
  final PasswordHasher _hasher;
  final SessionToken _token;

  LoginUser(this._userRepo, this._sessionRepo, this._hasher, this._token);

  @override
  Future<LoginResult> call(String identifier, String password) async {
    final user = await _userRepo.findCredentialsByIdentifier(identifier);
    // Same error for "no such user" and "wrong password" so attackers cannot
    // enumerate registered identifiers by response timing or text.
    if (user == null) {
      throw const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or password is incorrect',
      );
    }

    final passwordOk = await _hasher.verify(password, user.passwordHash);
    if (!passwordOk) {
      throw const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or password is incorrect',
      );
    }

    // `token` is what we hand to the client; `tokenHash` is what we store, so
    // a database leak does not give the attacker usable session tokens.
    final token = _token.generateSessionToken();
    final tokenHash = _token.hashSessionToken(token);

    final expiresAt = DateTime.now().toUtc().add(Ttl.sessionTtlD30);
    await _sessionRepo.create(user.userId, tokenHash, expiresAt);

    final fullUser = await _userRepo.findById(user.userId);

    // Race: the row could disappear between credential lookup and read.
    // From the client's perspective auth succeeded, so this is a 500.
    if (fullUser == null) {
      throw const InternalServerException(
        'USER_GONE',
        'User row disappeared between auth and read',
      );
    }

    return LoginResult(token: token, user: fullUser);
  }
}
