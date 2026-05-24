import 'package:backend/src/features/auth/shared/verify-email/domain/value_objects/email_code.dart';

abstract interface class IVerifyLoginEmailRepository {
  Future<EmailCode?> findActiveByUserId(String userId);
  Future<void> incrementAttempts(String id);
  Future<void> markConsumed(String id);
}
