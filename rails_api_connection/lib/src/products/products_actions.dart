import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'products.dart';
import '../app_config.dart';

class ProductsActions {
  final storage = new FlutterSecureStorage();

  Future<List<Product>> fetchPosts() async {
    final response =
        await http.get(AppConfig.API_BASE + 'api/v1/products', headers: {
      'access-token': await storage.read(key: 'accessToken'),
      'token-type': await storage.read(key: 'tokenType'),
      'expiry': await storage.read(key: 'expiry'),
      'client': await storage.read(key: 'client'),
      'uid': await storage.read(key: 'uid'),
    });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        final data = json.decode(response.body)['products'] as List;
        return data.map((rawProduct) {
          return Product(
              id: rawProduct['id'],
              userId: rawProduct['user_id'],
              name: rawProduct['name'],
              description: rawProduct['description'],
              productType: rawProduct['product_type'],
              createdAt: rawProduct['created_at'],
              updatedAt: rawProduct['updated_at']);
        }).toList();
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
