import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code_sender.dart';
import 'package:backend/src/features/auth/shared/ttl.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/register/start/domain/repository/i_pending_registration_repository.dart';
import 'package:backend/src/features/auth/shared/verify-email/domain/services/email_code.dart';
import 'package:backend/src/features/auth/register/start/domain/use_cases/start_registration_validate_use_case.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration.dart';
import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration_record.dart';
import 'package:backend/src/features/auth/login/password/domain/services/password_hasher.dart';
import 'package:injectable/injectable.dart';

abstract interface class IStartRegistrationUseCase {
  Future<PendingRegistration> call(StartRegistrationRequestDto data);
}

@LazySingleton(as: IStartRegistrationUseCase)
class StartRegistrationUseCase implements IStartRegistrationUseCase {
  final IStartRegistrationValidateUseCase _validateUseCase;
  final PasswordHasher _passwordHasher;
  final EmailCodeService _emailCodeService;
  final IPendingRegistrationRepository _pendingRegistrationRepository;
  final EmailCodeSenderService _emailCodeSenderService;

  StartRegistrationUseCase(
    this._validateUseCase,
    this._passwordHasher,
    this._emailCodeService,
    this._pendingRegistrationRepository,
    this._emailCodeSenderService,
  );

  @override
  Future<PendingRegistration> call(StartRegistrationRequestDto data) async {
    // validate login/email/password
    await _validateUseCase.validate(data);

    // hash password
    final passwordHash = await _passwordHasher.hash(data.password);

    // generate code email code
    final code = _emailCodeService.generateCode();
    final emailCodeHash = await _emailCodeService.hashEmailCode(code);
    final expiresAt = DateTime.now().toUtc().add(Ttl.emailCodeTtlM15);

    final registrationId = await _pendingRegistrationRepository.create(
      PendingRegistrationRecord(
        login: data.login.trim(),
        email: data.email.trim(),
        passwordHash: passwordHash,
        codeHash: emailCodeHash,
        expiresAt: expiresAt,
      ),
    );

    await _emailCodeSenderService.send(data.email.trim(), code);

    return PendingRegistration(registrationId: registrationId);
  }
}
