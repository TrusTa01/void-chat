import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';

abstract interface class IUserRepository {
  Future<UserEntity> create(NewUserRecord data);
  Future<UserEntity?> findById(int id);
  Future<UserEntity?> findByEmail(String email);
  Future<UserEntity?> findByLogin(String login);
}
