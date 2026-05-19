import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/shared/domain/value_objects/new_user.dart';
import 'package:backend/src/features/auth/shared/domain/value_objects/user_credentials.dart';

abstract interface class IUserRepository {
  Future<UserEntity> create(NewUserRecord data);
  Future<UserEntity?> findById(String id);
  Future<UserEntity?> findByEmail(String email);
  Future<UserEntity?> findByLogin(String login);

  Future<UserCredentials?> findCredentialsByIdentifier(String identifier);
}
