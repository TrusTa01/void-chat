import 'dart:math';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';

abstract interface class SessionToken {
  String generateSessionToken();
  String hashSessionToken(String token);
}

@LazySingleton(as: SessionToken)
class OpaqueBearerToken implements SessionToken {
  final Random _random = Random.secure();

  @override
  String generateSessionToken() {
    final values = List<int>.generate(32, (i) => _random.nextInt(256));
    final token = base64Url.encode(values);
    return token;
  }

  @override
  String hashSessionToken(String token) {
    final bytes = utf8.encode(token);
    final digest = sha256.convert(bytes);
    final hashedToken = digest.toString();
    return hashedToken;
  }
}
