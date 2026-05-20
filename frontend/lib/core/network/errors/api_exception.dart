class ApiFieldError {
  final String field;
  final String code;
  final String message;

  const ApiFieldError({
    required this.field,
    required this.code,
    required this.message,
  });

  factory ApiFieldError.fromJson(Map<String, dynamic> json) => ApiFieldError(
    field: json['field'] as String,
    code: json['code'] as String,
    message: json['message'] as String,
  );
}

class ApiException implements Exception {
  final String code;
  final String message;
  final int? statusCode;
  final List<ApiFieldError>? details;

  const ApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.details,
  });

  @override
  String toString() => 'ApiException($code): $message';
}
