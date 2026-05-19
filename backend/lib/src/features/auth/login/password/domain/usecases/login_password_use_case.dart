import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/shared/domain/use_cases/create_session_token_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/shared/domain/services/password_hasher.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILoginPasswordUseCase {
  Future<LoginResult> call(String identifier, String password);
}

@LazySingleton(as: ILoginPasswordUseCase)
class LoginPasswordUseCase implements ILoginPasswordUseCase {
  final IUserRepository _userRepo;
  final PasswordHasher _hasher;
  final ICreateSessionTokenUseCase _createSession;

  const LoginPasswordUseCase(this._userRepo, this._hasher, this._createSession);

  @override
  Future<LoginResult> call(String identifier, String password) async {
    final credentials = await _userRepo.findCredentialsByIdentifier(identifier);

    if (credentials == null) {
      throw const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or password is incorrect',
      );
    }

    final passwordOk = await _hasher.verify(password, credentials.passwordHash);
    if (!passwordOk) {
      throw const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or password is incorrect',
      );
    }

    return _createSession.create(credentials.userId);
  }
}
