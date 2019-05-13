import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rails_api_connection/rails_api_connection.dart';
import 'package:rails_api_connection/src/app_config.dart';
import 'package:rails_api_connection/src/storage_headers.dart';

class ApplicationActions {
  final storage = new FlutterSecureStorage();

  Future<List<Application>> fetchApplications() async {
    final response = await http.get(
        '${AppConfig.API_BASE}/api/v1/copyright_applications',
        headers: await StorageHeaders.getHeadersFromStorage());

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        final data =
            json.decode(response.body)['copyright_applications'] as List;
        return data.map((rawProduct) {
          return Application(
              id: rawProduct['id'],
              customerId: rawProduct['customer_id'],
              directorId: rawProduct['director_id'],
              acceptorId: rawProduct['acceptor_id'],
              executorId: rawProduct['executor_id'],
              title: rawProduct['title'],
              description: rawProduct['description'],
              status: rawProduct['status'],
              createdAt: rawProduct['created_at'],
              updatedAt: rawProduct['updated_at'],
              productId: rawProduct['product_id'],
              tasks: rawProduct['tasks']);
        }).toList();
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }

  Future<Application> showApplication(int id) async {
    final response = await http.get(
        '${AppConfig.API_BASE}/api/v1/copyright_applications/$id',
        headers: await StorageHeaders.getHeadersFromStorage());

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        final data = json.decode(response.body)['copyright_application'];
        return Application(
            id: data['id'],
            customerId: data['customer_id'],
            directorId: data['director_id'],
            acceptorId: data['acceptor_id'],
            executorId: data['executor_id'],
            title: data['title'],
            description: data['description'],
            status: data['status'],
            createdAt: data['created_at'],
            updatedAt: data['updated_at'],
            productId: data['product_id'],
            tasks: data['tasks']);
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
