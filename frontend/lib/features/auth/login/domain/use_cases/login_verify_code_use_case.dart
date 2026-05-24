import 'package:injectable/injectable.dart';
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

abstract interface class ILoginVerifyCodeUseCase {
  Future<UserEntity> call(String identifier, String code);
}

@LazySingleton(as: ILoginVerifyCodeUseCase)
class LoginVerifyCodeUseCaseImpl implements ILoginVerifyCodeUseCase {
  final ILoginRepository _repository;

  const LoginVerifyCodeUseCaseImpl(this._repository);

  @override
  Future<UserEntity> call(String identifier, String code) =>
      _repository.verifyLoginCode(identifier, code);
}
