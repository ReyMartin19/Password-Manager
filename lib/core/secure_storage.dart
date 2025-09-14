import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _masterKey = "masterPassword";

  static Future<void> saveMasterPassword(String password) async {
    await _storage.write(key: _masterKey, value: password);
  }

  static Future<String?> getMasterPassword() async {
    return await _storage.read(key: _masterKey);
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
