import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/new_user.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/user_credentials.dart';
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
        INSERT INTO auth.users (login, password_hash, email, email_confirmed_at, username, display_name, status)
        VALUES (@login, @password_hash, @email, NOW(), @username, @display_name, 'active')
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
    return guarded(() async {
      final result = await _pool.execute(
        Sql.named(
          '''
        SELECT id, email, username, display_name, created_at
        FROM auth.users 
        WHERE email = @email
        '''
              .trim(),
        ),
        parameters: {'email': email},
      );
      if (result.isEmpty) return null;
      return _mapRow(result.first);
    });
  }

  @override
  Future<UserEntity?> findById(String id) async {
    return guarded(() async {
      final result = await _pool.execute(
        Sql.named(
          '''
        SELECT id, email, username, display_name, created_at
        FROM auth.users 
        WHERE id = @id
        '''
              .trim(),
        ),
        parameters: {'id': id},
      );
      if (result.isEmpty) return null;
      return _mapRow(result.first);
    });
  }

  @override
  Future<UserEntity?> findByLogin(String login) async {
    return guarded(() async {
      final result = await _pool.execute(
        Sql.named(
          '''
        SELECT id, email, username, display_name, created_at
        FROM auth.users 
        WHERE login = @login
        '''
              .trim(),
        ),
        parameters: {'login': login},
      );
      if (result.isEmpty) return null;
      return _mapRow(result.first);
    });
  }

  @override
  Future<UserCredentials?> findCredentialsByIdentifier(String identifier) {
    return guarded(() async {
      final isEmail = identifier.contains('@');
      final sql = isEmail
          ? Sql.named(
              'SELECT id, password_hash FROM auth.users WHERE email = @id LIMIT 1'
                  .trim(),
            )
          : Sql.named(
              'SELECT id, password_hash FROM auth.users WHERE login = @id LIMIT 1'
                  .trim(),
            );
      final result = await _pool.execute(sql, parameters: {'id': identifier});
      if (result.isEmpty) return null;
      return _mapCredentialsRow(result.first);
    });
  }

  UserEntity _mapRow(ResultRow row) {
    final column = row.toColumnMap();
    // The Postgres driver decodes a UUID column to `UuidValue`, but a TEXT
    // column would arrive as `String`. `.toString()` is canonical for both,
    // so the repository stays correct even if the column type is changed.
    final id = (column['id']! as Object).toString();
    return UserEntity(
      id: id,
      email: column['email'] as String,
      username: column['username'] as String,
      displayName: column['display_name'] as String,
      createdAt: column['created_at'] as DateTime,
    );
  }

  UserCredentials? _mapCredentialsRow(ResultRow row) {
    final column = row.toColumnMap();
    final id = (column['id']! as Object).toString();
    return UserCredentials(
      userId: id,
      passwordHash: column['password_hash'] as String,
    );
  }
}
