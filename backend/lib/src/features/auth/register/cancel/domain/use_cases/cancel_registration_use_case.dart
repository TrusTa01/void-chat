import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICancelRegistrationUseCase {
  Future<void> call(String registrationId);
}

@LazySingleton(as: ICancelRegistrationUseCase)
class CancelRegistrationUseCase implements ICancelRegistrationUseCase {
  final ICompleteProfileRepository _repository;

  const CancelRegistrationUseCase(this._repository);

  @override
  Future<void> call(String registrationId) =>
      _repository.deleteById(registrationId);
}
