import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/register/verify_email/domain/repositories/i_verify_registration_email_repository.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code.dart';
import 'package:injectable/injectable.dart';

abstract interface class IVerifyRegistrationEmailUseCase {
  Future<void> call({required String registrationId, required String code});
}

@LazySingleton(as: IVerifyRegistrationEmailUseCase)
class VerifyRegistrationEmailUseCase
    implements IVerifyRegistrationEmailUseCase {
  final IVerifyRegistrationEmailRepository _repo;
  final EmailCodeService _emailService;

  const VerifyRegistrationEmailUseCase(this._repo, this._emailService);

  static const int maxAttempts = 5;

  @override
  Future<void> call({
    required String registrationId,
    required String code,
  }) async {
    final pending = await _repo.findVerificationById(registrationId);

    if (pending == null) {
      throw const ValidationException(
        AuthErrorCodes.invalidRegistration,
        'Registration was not found',
      );
    }

    if (pending.verifiedAt != null) return;

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
      await _repo.incrementAttempts(registrationId);
      throw const ValidationException(
        AuthErrorCodes.invalidEmailCode,
        'Email verification code is invalid',
      );
    }

    await _repo.markVerified(registrationId);
  }
}
