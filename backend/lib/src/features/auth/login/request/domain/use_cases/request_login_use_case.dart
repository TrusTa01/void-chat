import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/login/request/domain/repositories/i_request_login_repository.dart';
import 'package:backend/src/features/auth/shared/domain/services/email_code_resend_policy.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code_sender.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:injectable/injectable.dart';

abstract interface class IRequestLoginUseCase {
  Future<void> send(String identifier);
}

@LazySingleton(as: IRequestLoginUseCase)
class RequestLoginUseCase implements IRequestLoginUseCase {
  final IUserRepository _userRepository;
  final EmailCodeService _codeService;
  final IRequestLoginRepository _requestLoginRepository;
  final EmailCodeSenderService _emailService;
  final EmailCodeResendPolicy _cooldownPolicy;

  const RequestLoginUseCase(
    this._userRepository,
    this._codeService,
    this._requestLoginRepository,
    this._emailService,
    this._cooldownPolicy,
  );

  @override
  Future<void> send(String identifier) async {
    final credentials = await _userRepository.findCredentialsByIdentifier(
      identifier,
    );
    if (credentials == null) return;

    final user = await _userRepository.findById(credentials.userId);
    if (user == null) return;

    final lastSent = await _requestLoginRepository.findLastCodeCreatedAt(
      credentials.userId,
    );
    _cooldownPolicy.ensureAllowed(lastSent);

    final code = _codeService.generateCode();
    final codeHash = await _codeService.hashEmailCode(code);

    await _requestLoginRepository.insertCode(
      userId: credentials.userId,
      codeHash: codeHash,
      expiresAt: DateTime.now().toUtc().add(Ttl.emailCodeTtlM15),
    );

    await _emailService.send(user.email, code);
  }
}
