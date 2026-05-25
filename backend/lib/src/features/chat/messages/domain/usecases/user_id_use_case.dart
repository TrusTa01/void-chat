import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:backend/src/features/auth/shared/domain/services/session_token.dart';
import 'package:injectable/injectable.dart';

abstract interface class IUserIdUseCase {
  Future<String?> call(String token);
}

@LazySingleton(as: IUserIdUseCase)
class UserIdUseCaseImpl implements IUserIdUseCase {
  final SessionToken _sessionToken;
  final ISessionRepository _sessionRepository;

  const UserIdUseCaseImpl(this._sessionToken, this._sessionRepository);

  @override
  Future<String?> call(String token) {
    final tokenHash = _sessionToken.hashSessionToken(token);
    return _sessionRepository.findUserIdByTokenHash(tokenHash);
  }
}
