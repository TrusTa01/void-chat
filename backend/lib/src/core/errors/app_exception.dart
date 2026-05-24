sealed class AppException implements Exception {
  final String code;
  final String message;
  final int statusCode;

  const AppException(this.code, this.message, this.statusCode);
}

// 400, fail fast
class ValidationException extends AppException {
  const ValidationException(String code, String message)
    : super(code, message, 400);
}

// 400, aggregate
class ValidationFailedException extends AppException {
  final List<FieldError> details;
  const ValidationFailedException(this.details)
    : super('VALIDATION_FAILED', 'Some fields are invalid', 400);
}

// 401
class UnauthorizedException extends AppException {
  const UnauthorizedException(String code, String message)
    : super(code, message, 401);
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException(String code, String message)
    : super(code, message, 429);
}

// 403
class ForbiddenException extends AppException {
  const ForbiddenException(String code, String message)
    : super(code, message, 403);
}

// 404
class NotFoundException extends AppException {
  const NotFoundException(String code, String message)
    : super(code, message, 404);
}

// 409
class ConflictException extends AppException {
  const ConflictException(String code, String message)
    : super(code, message, 409);
}

// 500
class InternalServerException extends AppException {
  const InternalServerException(String code, String message)
    : super(code, message, 500);
}

// 503
class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException(String code, String message)
    : super(code, message, 503);
}

// 504
class GatewayTimeoutException extends AppException {
  const GatewayTimeoutException(String code, String message)
    : super(code, message, 504);
}

class FieldError {
  final String field; // 'email', 'password', ...
  final String code; // 'INVALID_EMAIL', 'WEAK_PASSWORD'
  final String message; // 'Email format is invalid'

  const FieldError({
    required this.field,
    required this.code,
    required this.message,
  });
}
