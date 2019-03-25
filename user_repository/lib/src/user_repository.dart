import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    // TODO: User real connection
    return 'token';
  }

  Future<void> deleteToken() async {
    // TODO: delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    // TODO: write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    // TODO: read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
