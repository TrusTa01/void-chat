import 'package:dargon2/dargon2.dart';
import 'package:injectable/injectable.dart';

abstract interface class PasswordHasher {
  Future<String> hash(String password);
  Future<bool> verify(String password, String encodedHash);
}

@LazySingleton(as: PasswordHasher)
class Argon2idPasswordHasher implements PasswordHasher {
  final int memory;
  final int iterations;
  final int parallelism;
  final int hashLength;
  final int saltLength;

  const Argon2idPasswordHasher({
    this.memory = 65536, // 64 MiB
    this.iterations = 2,
    this.parallelism = 2,
    this.hashLength = 32,
    this.saltLength = 16,
  });

  @override
  Future<String> hash(String password) async {
    final salt = Salt.newSalt(length: saltLength);
    final result = await argon2.hashPasswordString(
      password,
      salt: salt,
      iterations: iterations,
      memory: memory,
      parallelism: parallelism,
      length: hashLength,
      type: Argon2Type.id,
      version: Argon2Version.V13,
    );
    return result.encodedString;
  }

  @override
  Future<bool> verify(String password, String encodedHash) =>
      argon2.verifyHashString(password, encodedHash);
}
