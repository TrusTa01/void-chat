import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/pending_registration_for_completion.dart';

abstract interface class ICompleteProfileRepository {
  Future<PendingRegistrationForCompletion?> findForCompletionById(String id);
  Future<void> deleteById(String id);
}
