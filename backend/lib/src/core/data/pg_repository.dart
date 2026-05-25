import 'package:backend/src/core/data/pg_error_handling_mixin.dart';
import 'package:postgres/postgres.dart';

abstract class PgRepository with PgErrorHandling {
  final Pool<Connection> pool;

  const PgRepository(this.pool);
}
