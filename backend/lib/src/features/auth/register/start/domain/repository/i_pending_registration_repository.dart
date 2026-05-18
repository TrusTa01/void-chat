import 'package:backend/src/features/auth/register/start/domain/value_objects/pending_registration_record.dart';

abstract interface class IPendingRegistrationRepository {
  Future<String> create(PendingRegistrationRecord data);
}
