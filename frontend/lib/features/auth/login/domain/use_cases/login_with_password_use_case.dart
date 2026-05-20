import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

abstract interface class ILoginWithPasswordUseCase {
  Future<UserEntity> call(String identifier, String password);
}

@LazySingleton(as: ILoginWithPasswordUseCase)
class LoginWithPasswordUseCase implements ILoginWithPasswordUseCase {
  final ILoginRepository _repository;

  const LoginWithPasswordUseCase(this._repository);

  @override
  Future<UserEntity> call(String identifier, String password) =>
      _repository.loginWithPassword(identifier, password);
}
