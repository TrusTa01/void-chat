import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/login_result.dart';
import 'package:backend/src/features/auth/login/shared/domain/use_cases/create_session_token_use_case.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/repositories/i_verify_email_repository.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code.dart';
import 'package:injectable/injectable.dart';

abstract interface class IVerifyEmailUseCase {
  Future<LoginResult> verify({
    required String identifier,
    required String code,
  });
}

@LazySingleton(as: IVerifyEmailUseCase)
class VerifyEmailUseCase implements IVerifyEmailUseCase {
  final IUserRepository _userRepository;
  final IVerifyEmailRepository _verifyLoginEmailRepo;
  final EmailCodeService _emailService;
  final ICreateSessionTokenUseCase _createSession;

  const VerifyEmailUseCase(
    this._userRepository,
    this._verifyLoginEmailRepo,
    this._emailService,
    this._createSession,
  );

  static const int maxAttempts = 5;

  @override
  Future<LoginResult> verify({
    required String identifier,
    required String code,
  }) async {
    final credentials = await _userRepository.findCredentialsByIdentifier(
      identifier,
    );
    if (credentials == null) {
      throw const UnauthorizedException(
        AuthErrorCodes.invalidCredentials,
        'Email or code is incorrect',
      );
    }

    final pending = await _verifyLoginEmailRepo.findActiveByUserId(
      credentials.userId,
    );
    if (pending == null) {
      throw const ValidationException(
        AuthErrorCodes.invalidEmailCode,
        'Email verification code is invalid',
      );
    }

    final now = DateTime.now().toUtc();
    if (!pending.expiresAt.toUtc().isAfter(now)) {
      throw const ValidationException(
        AuthErrorCodes.emailCodeExpired,
        'Email verification code has expired',
      );
    }

    if (pending.attempts >= maxAttempts) {
      throw const ValidationException(
        AuthErrorCodes.emailCodeAttemptsExceeded,
        'Too many incorrect email verification attempts',
      );
    }

    final codeOk = await _emailService.verifyCode(code, pending.codeHash);
    if (!codeOk) {
      await _verifyLoginEmailRepo.incrementAttempts(pending.id);
      throw const ValidationException(
        AuthErrorCodes.invalidEmailCode,
        'Email verification code is invalid',
      );
    }

    await _verifyLoginEmailRepo.markConsumed(pending.id);
    return _createSession.create(credentials.userId);
  }
}
