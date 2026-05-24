import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

class SecureStorageFactory {
  @factoryMethod
  static FlutterSecureStorage create() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
        groupId: 'group.com.void.chat.app',
      ),
    );
  }
}