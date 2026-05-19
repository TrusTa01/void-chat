import 'dart:math';

import 'package:backend/src/features/auth/shared/domain/services/password_hasher.dart';
import 'package:injectable/injectable.dart';

abstract interface class EmailCodeService {
  String generateCode();
  Future<String> hashEmailCode(String code);
  Future<bool> verifyCode(String code, String codeHash);
}

@LazySingleton(as: EmailCodeService)
class EmailCodeServiceImpl implements EmailCodeService {
  final PasswordHasher _hasher;
  final Random _random = Random.secure();

  EmailCodeServiceImpl(this._hasher);

  @override
  String generateCode() {
    final value = _random.nextInt(10000);
    return value.toString().padLeft(4, '0');
  }

  @override
  Future<String> hashEmailCode(String code) => _hasher.hash(code);

  @override
  Future<bool> verifyCode(String code, String codeHash) =>
      _hasher.verify(code, codeHash);
}
