import 'package:backend/src/features/auth/register/verify_email/domain/value_objects/pending_registration_verification.dart';

abstract interface class IVerifyRegistrationEmailRepository {
  Future<PendingRegistrationVerification?> findVerificationById(String id);
  Future<void> incrementAttempts(String id);
  Future<void> markVerified(String id);
}
