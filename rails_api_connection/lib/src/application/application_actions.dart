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
            tasks: _mapTasks(rawProduct['tasks']),
          );
        }).toList();
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }

  List<ApplicationTask> _mapTasks(data) {
    var applicationTasks = new List<ApplicationTask>();
    data.forEach((task) => applicationTasks.add(new ApplicationTask(
        id: task['id'],
        copyrightApplicationId: task['copyright_application_id'],
        title: task['title'],
        done: task['done'],
        createdAt: task['created_at'],
        updatedAt: task['updated_at'])));
    return applicationTasks;
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
          tasks: _mapTasks(data['tasks']),
        );
      } else {
        throw Exception('Success is false');
      }
    } else {
      throw Exception('Error fetching posts');
    }
  }

  Future<bool> createApplication({productId, title, description, tasks}) async {
    final res =
        await http.post('${AppConfig.API_BASE}/api/v1/copyright_applications',
            body: {
              'product_id': productId,
              'title': title,
              'description': description,
              'tasks': jsonDecode(jsonEncode(tasks))
            },
            headers: await StorageHeaders.getHeadersFromStorage());

    if (res.statusCode == 201) {
      final responseBody = json.decode(res.body);
      if (responseBody['success'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void storeProductId({id}) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'product_id', value: id.toString());
  }
}
