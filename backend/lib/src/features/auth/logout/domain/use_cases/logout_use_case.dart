import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILogoutUseCase {
  Future<void> call(String accessToken);
}

@LazySingleton(as: ILogoutUseCase)
class LogoutUseCase implements ILogoutUseCase {
  final SessionToken _sessionToken;
  final ISessionRepository _sessions;

  const LogoutUseCase(this._sessionToken, this._sessions);

  @override
  Future<void> call(String accessToken) async {
    final tokenHash = _sessionToken.hashSessionToken(accessToken);
    await _sessions.deleteTokenByHash(tokenHash);
  }
}
