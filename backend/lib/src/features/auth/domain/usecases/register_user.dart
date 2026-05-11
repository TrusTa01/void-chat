import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/domain/services/password_hasher.dart';
import 'package:backend/src/features/auth/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/domain/policies/registration_policies.dart';
import 'package:backend/src/features/auth/domain/repository/i_user_repository.dart';
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';
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
    // Run every policy and aggregate their findings before deciding to throw.
    // This guarantees the client gets all policy violations in one round
    // trip, mirroring the contract of the field validator
    final errors = <FieldError>[];
    _loginPolicy.check(data.login, errors);
    _emailPolicy.check(data.email, errors);
    _usernamePolicy.check(data.username, errors);
    _displayNamePolicy.check(data.displayName, errors);

    if (errors.isNotEmpty) {
      throw ValidationFailedException(errors);
    }

    // Hashing is intentionally deferred until policies succeed so we
    // do not waste the (deliberately expensive) Argon2id work on rejected
    // payloads
    final passwordHash = await _hasher.hash(data.password);

    final record = NewUserRecord(
      login: data.login,
      passwordHash: passwordHash,
      email: data.email,
      username: data.username,
      displayName: data.displayName,
    );

    return _repo.create(record);
  }
}
