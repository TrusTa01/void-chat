import 'package:postgres/postgres.dart';

/// UUID columns decode to `UuidValue`; TEXT columns to `String`.
/// [toString] is canonical for both.
String pgCellId(Object? value) => (value as Object).toString();

String pgColumnId(Map<String, Object?> row, String column) =>
    pgCellId(row[column]);

extension PgResultRowX on ResultRow {
  Map<String, Object?> get columns => toColumnMap();

  String cellId(String column) => pgColumnId(columns, column);
}

extension PgResultX on Result {
  T mapFirst<T>(T Function(ResultRow row) mapper) => mapper(first);

  T? mapFirstOrNull<T>(T Function(ResultRow row) mapper) {
    if (isEmpty) return null;
    return mapper(first);
  }

  List<T> mapAll<T>(
    T Function(ResultRow row) mapper, {
    bool growable = false,
  }) => map(mapper).toList(growable: growable);
}
