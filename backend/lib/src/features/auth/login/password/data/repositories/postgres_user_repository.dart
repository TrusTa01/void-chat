import 'package:backend/src/core/data/pg_repository.dart';
import 'package:backend/src/core/data/pg_row.dart';
import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/new_user.dart';
import 'package:backend/src/features/auth/login/password/domain/value_objects/user_credentials.dart';
import 'package:injectable/injectable.dart';
import 'package:postgres/postgres.dart';

@LazySingleton(as: IUserRepository)
class PostgresUserRepository extends PgRepository implements IUserRepository {
  const PostgresUserRepository(super.pool);

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
      final result = await pool.execute(
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

      return result.mapFirst(_mapRow);
    });
  }

  @override
  Future<UserEntity?> findByEmail(String email) async {
    return guarded(() async {
      final result = await pool.execute(
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
      return result.mapFirstOrNull(_mapRow);
    });
  }

  @override
  Future<UserEntity?> findById(String id) async {
    return guarded(() async {
      final result = await pool.execute(
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
      return result.mapFirstOrNull(_mapRow);
    });
  }

  @override
  Future<UserEntity?> findByLogin(String login) async {
    return guarded(() async {
      final result = await pool.execute(
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
      return result.mapFirstOrNull(_mapRow);
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
      final result = await pool.execute(sql, parameters: {'id': identifier});
      return result.mapFirstOrNull(_mapCredentialsRow);
    });
  }

  UserEntity _mapRow(ResultRow row) {
    final column = row.columns;
    return UserEntity(
      id: row.cellId('id'),
      email: column['email'] as String,
      username: column['username'] as String,
      displayName: column['display_name'] as String,
      createdAt: column['created_at'] as DateTime,
    );
  }

  UserCredentials _mapCredentialsRow(ResultRow row) {
    final column = row.columns;
    return UserCredentials(
      userId: row.cellId('id'),
      passwordHash: column['password_hash'] as String,
    );
  }
}
