import 'package:backend/core/security/password_hasher.dart';
import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/policies/registration_policies.dart';
import 'package:backend/features/auth/domain/repository/i_user_repository.dart';
import 'package:backend/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:injectable/injectable.dart';

export 'i_register_user.dart' show IRegisterUser;

@LazySingleton(as: IRegisterUser)
class RegisterUser implements IRegisterUser {
  final IUserRepository _repo;
  final PasswordHasher _hasher;
  final LoginPolicy _loginPolicy;
  final EmailPolicy _emailPolicy;
  final UsernamePolicy _usernamePolicy;
  final DisplayNamePolicy _displayNamePolicy;

  const RegisterUser(
    this._repo,
    this._hasher,
    this._loginPolicy,
    this._emailPolicy,
    this._usernamePolicy,
    this._displayNamePolicy,
  );

  @override
  Future<UserEntity> call(NewUser data) async {
    final login = _loginPolicy.ensure(data.login);
    final passwordHash = await _hasher.hash(data.password);
    final email = _emailPolicy.ensure(data.email);
    final username = _usernamePolicy.ensure(data.username);
    final displayName = _displayNamePolicy.ensure(data.displayName);

    final record = NewUserRecord(
      login: login,
      passwordHash: passwordHash,
      email: email,
      username: username,
      displayName: displayName,
    );

    return _repo.create(record);
  }
}
