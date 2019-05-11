import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rails_api_connection/src/user/user.dart';
import 'package:rails_api_connection/src/user/user_body.dart';
import 'package:rails_api_connection/src/user/user_headers.dart';

import '../app_config.dart';
import '../storage_headers.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();

  Future<User> getUserFromServer(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception(json.decode(response.body)['errors'][0]);
      }

      User user = new User(
          userHeaders: UserHeaders.fromJson(response.headers),
          userBody: UserBody.fromJson(json.decode(response.body)));
      return user;
    });
  }

  Future<void> removeUserHeadersFromServer(String url) async {
    return http
        .delete(url, headers: await StorageHeaders.getHeadersFromStorage())
        .then((http.Response response) {
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
    User user = await getUserFromServer('${AppConfig.API_BASE}/auth/sign_in',
        body: {"email": email, "password": password});
    return user;
  }

  Future<User> register({
    @required String email,
    @required String password,
    @required String passwordConfirmation,
  }) async {
    User user = await getUserFromServer('${AppConfig.API_BASE}/auth', body: {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
    return user;
  }

  Future<void> deleteHeaders() async {
    await removeUserHeadersFromServer('${AppConfig.API_BASE}/auth/sign_out');
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
    Map<String, String> userHeadersFromStorage =
        await StorageHeaders.getHeadersFromStorage();
    if (userHeadersFromStorage.values.contains(null)) {
      return false;
    }
    return true;
  }
}
