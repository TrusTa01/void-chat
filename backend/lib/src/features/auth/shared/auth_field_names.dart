/// API field names used in `FieldError.field` so the frontend can map
/// validation errors to the corresponding form input.
///
/// Values are intentionally kept in `snake_case` to match the wire format
/// of [RegisterRequestDto] (see `@JsonKey` annotations there). Sharing them
/// between domain (validators, policies) and API layers is a pragmatic
/// shortcut: it is a small leak but it keeps `details[].field` consistent
/// with the request payload the client just sent.
abstract class AuthFieldNames {
  static const String login = 'login';
  static const String password = 'password';
  static const String email = 'email';
  static const String username = 'username';
  static const String displayName = 'display_name';
}
