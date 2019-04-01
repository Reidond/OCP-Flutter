import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'user_headers.dart';
import 'user_body.dart';
import 'user.dart';
import 'app_config.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();

  Future<User> getUserFromServer(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 ||
          statusCode > 400 && statusCode != 422 ||
          json == null) {
        throw new Exception("Error while fetching data");
      }

      if (statusCode == 422) {
        throw new Exception('This user is already registered');
      }

      User user = new User(
          userHeaders: UserHeaders.fromJson(response.headers),
          userBody: UserBody.fromJson(json.decode(response.body)));
      return user;
    });
  }

  Future<void> removeUserHeadersFromServer(String url) async {
    return http.delete(url, headers: {
      'access-token': await storage.read(key: 'accessToken'),
      'token-type': await storage.read(key: 'tokenType'),
      'expiry': await storage.read(key: 'expiry'),
      'client': await storage.read(key: 'client'),
      'uid': await storage.read(key: 'uid'),
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {
    User user = await getUserFromServer(AppConfig.API_BASE + 'auth/sign_in',
        body: {"email": email, "password": password});
    return user;
  }

  Future<User> register({
    @required String email,
    @required String password,
    @required String passwordConfirmation,
  }) async {
    User user = await getUserFromServer(AppConfig.API_BASE + 'auth', body: {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
    return user;
  }

  Future<void> deleteHeaders() async {
    await removeUserHeadersFromServer(AppConfig.API_BASE + 'auth/sign_out');
    await storage.delete(key: 'client');
    await storage.delete(key: 'expiry');
    await storage.delete(key: 'tokenType');
    await storage.delete(key: 'uid');
    await storage.delete(key: 'accessToken');
    return;
  }

  Future<void> persistHeaders(User user) async {
    await storage.write(key: 'client', value: user.userHeaders.client);
    await storage.write(key: 'expiry', value: user.userHeaders.expiry);
    await storage.write(key: 'tokenType', value: user.userHeaders.tokenType);
    await storage.write(key: 'uid', value: user.userHeaders.uid);
    await storage.write(
        key: 'accessToken', value: user.userHeaders.accessToken);
    return;
  }

  Future<bool> hasHeaders() async {
    Map<String, String> userHeadersFromStorage = new Map<String, String>();
    userHeadersFromStorage['accessToken'] =
        await storage.read(key: 'accessToken');
    userHeadersFromStorage['uid'] = await storage.read(key: 'uid');
    userHeadersFromStorage['tokenType'] = await storage.read(key: 'tokenType');
    userHeadersFromStorage['expiry'] = await storage.read(key: 'expiry');
    userHeadersFromStorage['client'] = await storage.read(key: 'client');
    if (userHeadersFromStorage.values.contains(null)) {
      return false;
    }
    return true;
  }
}
