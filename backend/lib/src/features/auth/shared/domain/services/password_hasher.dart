import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:argon2/argon2.dart';
import 'package:injectable/injectable.dart';

abstract interface class PasswordHasher {
  Future<String> hash(String password);
  Future<bool> verify(String password, String encodedHash);
}

@LazySingleton(as: PasswordHasher)
class Argon2idPasswordHasher implements PasswordHasher {
  static const _formatPrefix = 'argon2id_v1';
  static const _memory = 65536; // 64 MiB
  static const _iterations = 2;
  static const _parallelism = 2;
  static const _hashLength = 32;
  static const _saltLength = 16;

  const Argon2idPasswordHasher();

  @override
  Future<String> hash(String password) async {
    final salt = _generateSalt(_saltLength);
    final hash = _deriveHash(
      password: password,
      salt: salt,
      iterations: _iterations,
      memory: _memory,
      parallelism: _parallelism,
      hashLength: _hashLength,
    );

    return [
      _formatPrefix,
      _iterations.toString(),
      _memory.toString(),
      _parallelism.toString(),
      base64UrlEncode(salt),
      base64UrlEncode(hash),
    ].join(r'$');
  }

  @override
  Future<bool> verify(String password, String encodedHash) async {
    final parts = encodedHash.split(r'$');
    if (parts.length != 6 || parts.first != _formatPrefix) {
      return false;
    }

    final parsedIterations = int.tryParse(parts[1]);
    final parsedMemory = int.tryParse(parts[2]);
    final parsedParallelism = int.tryParse(parts[3]);
    if (parsedIterations == null ||
        parsedMemory == null ||
        parsedParallelism == null) {
      return false;
    }

    late Uint8List salt;
    late Uint8List expectedHash;
    try {
      salt = Uint8List.fromList(base64Url.decode(parts[4]));
      expectedHash = Uint8List.fromList(base64Url.decode(parts[5]));
    } on FormatException {
      return false;
    }

    final actualHash = _deriveHash(
      password: password,
      salt: salt,
      iterations: parsedIterations,
      memory: parsedMemory,
      parallelism: parsedParallelism,
      hashLength: expectedHash.length,
    );
    return _constantTimeEquals(expectedHash, actualHash);
  }

  Uint8List _deriveHash({
    required String password,
    required Uint8List salt,
    required int iterations,
    required int memory,
    required int parallelism,
    required int hashLength,
  }) {
    final params = Argon2Parameters(
      Argon2Parameters.ARGON2_id,
      salt,
      iterations: iterations,
      memory: memory,
      lanes: parallelism,
      version: Argon2Parameters.ARGON2_VERSION_13,
    );
    final generator = Argon2BytesGenerator()..init(params);
    final output = Uint8List(hashLength);
    generator.generateBytesFromString(password, output);
    return output;
  }

  Uint8List _generateSalt(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }

  bool _constantTimeEquals(Uint8List left, Uint8List right) {
    if (left.length != right.length) return false;
    var diff = 0;
    for (var i = 0; i < left.length; i++) {
      diff |= left[i] ^ right[i];
    }
    return diff == 0;
  }
}
