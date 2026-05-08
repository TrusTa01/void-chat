import 'package:backend/core/data/pg_error_handling_mixin.dart';
import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/features/auth/auth_error_codes.dart';
import 'package:backend/features/auth/domain/entities/user_entity.dart';
import 'package:backend/features/auth/domain/repository/i_user_repository.dart';
import 'package:backend/features/auth/domain/value_objects/new_user.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IUserRepository)
class PostgresUserRepository with PgErrorHandling implements IUserRepository {
  final Pool<Connection> _pool;

  PostgresUserRepository(this._pool);

  /// Refines unique-violation errors that come from `auth.users` into
  /// auth-specific [ConflictException]s. Falls back to the generic
  /// CONFLICT response for any other UNIQUE index on the table.
  @override
  AppException mapUniqueViolation(ServerException e) {
    switch (e.constraintName) {
      case 'users_email_key':
        return const ConflictException(
          AuthErrorCodes.emailTaken,
          'This email is already registered',
        );
      case 'users_username_key':
        return const ConflictException(
          AuthErrorCodes.usernameTaken,
          'This username is already in use',
        );
      default:
        return super.mapUniqueViolation(e);
    }
  }

  @override
  Future<UserEntity> create(NewUserRecord data) {
    return guarded(() async {
      final result = await _pool.execute(
        Sql.named(
          '''
        INSERT INTO auth.users (login, password_hash, email, username, display_name)
        VALUES (@login, @password_hash, @email, @username, @display_name)
        RETURNING id, email, username, display_name, created_at
        '''
              .trim(),
        ),
        parameters: {
          'login': data.login,
          'password_hash': data.passwordHash,
          'email': data.email,
          'username': data.username,
          'display_name': data.displayName,
        },
      );
      return _mapRow(result.first);
    });
  }

  @override
  Future<UserEntity?> findByEmail(String email) async {
    // TODO: implement finalByEmail
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> findById(int id) async {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> findByLogin(String login) async {
    // TODO: implement findByLogin
    throw UnimplementedError();
  }

  UserEntity _mapRow(ResultRow row) {
    final m = row.toColumnMap();
    return UserEntity(
      id: m['id'] as int,
      email: m['email'] as String,
      username: m['username'] as String,
      displayName: m['display_name'] as String,
      createdAt: m['created_at'] as DateTime,
    );
  }
}
