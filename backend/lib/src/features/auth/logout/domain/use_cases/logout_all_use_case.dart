import 'package:backend/src/features/auth/login/password/domain/repositories/i_session_repository.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILogoutAllUseCase {
  Future<void> call(String userId);
}

@LazySingleton(as: ILogoutAllUseCase)
class LogoutAllUseCase implements ILogoutAllUseCase {
  final ISessionRepository _sessions;

  const LogoutAllUseCase(this._sessions);

  @override
  Future<void> call(String userId) => _sessions.deleteAllByUserId(userId);
}
