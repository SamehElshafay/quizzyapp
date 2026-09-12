import 'package:quizzy_app/utils/secure_storage_helper.dart';

class AuthTokenService {
  static AuthTokenService? _instance;
  static AuthTokenService get instance => _instance ??= AuthTokenService._();
  AuthTokenService._();
  final SecureStorageHelper secureStorageHelper = SecureStorageHelper();
  static const _authTokenKey = 'authToken';

  Future<String?> read() async {
    return await secureStorageHelper.read(_authTokenKey);
  }

  Future<void> add({required String value}) async {
    await secureStorageHelper.write(_authTokenKey, value);
  }

  Future<void> delete() async {
    await secureStorageHelper.delete(_authTokenKey);
  }
}
