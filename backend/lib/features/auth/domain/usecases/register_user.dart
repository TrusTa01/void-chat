import 'package:backend/core/security/password_hasher.dart';
import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/repository/i_user_repository.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:injectable/injectable.dart';

abstract interface class IRegisterUser {
  Future<UserEntity> call(NewUser data);
}

@LazySingleton(as: IRegisterUser)
class RegisterUser implements IRegisterUser {
  final IUserRepository _repo;
  final PasswordHasher _hasher;

  const RegisterUser(this._repo, this._hasher);

  @override
  Future<UserEntity> call(NewUser data) async {
    final hash = await _hasher.hash(data.password);
    final record = NewUserRecord(
      login: data.login,
      passwordHash: hash,
      email: data.email,
      username: data.username,
      displayName: data.displayName,
    );

    return _repo.create(record);
  }
}
