import 'package:seller/core/auth/error_auth.dart';
import 'package:seller/core/auth/model/token.dart';
import 'package:seller/core/auth/repo/token_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  LocalStorage._();
  static final _instance = LocalStorage._();
  factory LocalStorage() {
    return _instance;
  }

  final storage = const FlutterSecureStorage();
  static const keyToken = 'auth_token';

  Future<void> saveToken(AuthToken token) async {
    final tokenData = TokenData.fromSuper(token);
    final json = tokenData.toJson();
    try {
      await storage.write(key: keyToken, value: json);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthToken> getToken() async {
    try {
      final data = await storage.read(key: keyToken);
      if (data != null) return TokenData.fromJson(data);
      throw LocalAuthError();
    } catch (e) {
      throw LocalAuthError();
    }
  }

  Future<void> removeToken() async {
    await storage.write(key: keyToken, value: '');
  }
}
