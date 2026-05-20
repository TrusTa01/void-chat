abstract final class ApiConfig {
  static String get baseUrl => 'http://10.0.2.2:8082';
  static Duration get connectTimeout => const Duration(seconds: 15);
  static Duration get receiveTimeout => const Duration(seconds: 15);
}
