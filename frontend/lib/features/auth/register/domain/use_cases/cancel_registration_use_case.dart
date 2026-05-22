import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/register/domain/repositories/i_register_repository.dart';

abstract interface class ICancelRegistrationUseCase {
  Future<void> call(String registrationId);
}

@LazySingleton(as: ICancelRegistrationUseCase)
class CancelRegistrationUseCaseImpl implements ICancelRegistrationUseCase {
  final IRegisterRepository _repository;

  const CancelRegistrationUseCaseImpl(this._repository);

  @override
  Future<void> call(String registrationId) =>
      _repository.cancelRegistration(registrationId: registrationId);
}
