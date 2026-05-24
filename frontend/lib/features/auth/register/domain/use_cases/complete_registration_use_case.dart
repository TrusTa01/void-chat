import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/register/domain/repositories/i_register_repository.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

abstract interface class ICompleteRegistrationUseCase {
  Future<UserEntity> call({
    required String registrationId,
    required String username,
    required String displayName,
  });
}

@LazySingleton(as: ICompleteRegistrationUseCase)
class CompleteRegistrationUseCaseImpl implements ICompleteRegistrationUseCase {
  final IRegisterRepository _repository;

  const CompleteRegistrationUseCaseImpl(this._repository);

  @override
  Future<UserEntity> call({
    required String registrationId,
    required String username,
    required String displayName,
  }) => _repository.completeRegistration(
    registrationId: registrationId,
    username: username,
    displayName: displayName,
  );
}
