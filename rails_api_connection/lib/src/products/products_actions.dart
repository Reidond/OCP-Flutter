import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rails_api_connection/src/app_config.dart';
import 'package:rails_api_connection/src/products/product.dart';
import 'package:rails_api_connection/src/storage_headers.dart';

class ProductsActions {
  final storage = new FlutterSecureStorage();

  Future<List<Product>> fetchProducts() async {
    final response = await http.get('${AppConfig.API_BASE}/api/v1/products',
        headers: await StorageHeaders.getHeadersFromStorage());

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

  Future<Product> showProduct(int id) async {
    final response = await http.get('${AppConfig.API_BASE}/api/v1/products/$id',
        headers: await StorageHeaders.getHeadersFromStorage());

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        final data = json.decode(response.body)['product'];
        return Product(
            id: data['id'],
            userId: data['user_id'],
            name: data['name'],
            description: data['description'],
            productType: data['product_type'],
            createdAt: data['created_at'],
            updatedAt: data['updated_at']);
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
