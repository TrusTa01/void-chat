import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart';

abstract interface class ILoginWithCodeUseCase {
  Future<void> call(String identifier);
}

@LazySingleton(as: ILoginWithCodeUseCase)
class LoginWithCodeUseCaseImpl implements ILoginWithCodeUseCase {
  final ILoginRepository _repository;

  const LoginWithCodeUseCaseImpl(this._repository);

  @override
  Future<void> call(String identifier) => _repository.loginWithCode(identifier);
}
