import 'package:backend/src/features/auth/login/verify/domain/value_objects/login_email_code.dart';

abstract interface class IVerifyLoginEmailRepository {
  Future<LoginEmailCode?> findActiveByUserId(String userId);
  Future<void> incrementAttempts(String id);
  Future<void> markConsumed(String id);
}
