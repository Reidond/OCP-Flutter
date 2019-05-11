import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHeaders {
  static getHeadersFromStorage() async {
    final storage = new FlutterSecureStorage();
    return {
      'access-token': await storage.read(key: 'accessToken'),
      'token-type': await storage.read(key: 'tokenType'),
      'expiry': await storage.read(key: 'expiry'),
      'client': await storage.read(key: 'client'),
      'uid': await storage.read(key: 'uid'),
    };
  }
}
