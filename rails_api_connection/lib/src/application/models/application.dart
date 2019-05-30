import 'package:equatable/equatable.dart';
import 'package:rails_api_connection/src/application/index.dart';

class Application extends Equatable {
  final int id;
  final int customerId;
  final int directorId;
  final int acceptorId;
  final int executorId;
  final String title;
  final String description;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int productId;
  final List<ApplicationTask> tasks;

  Application(
      {this.id,
      this.customerId,
      this.directorId,
      this.acceptorId,
      this.executorId,
      this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.productId,
      this.tasks})
      : super([
          id,
          customerId,
          directorId,
          acceptorId,
          executorId,
          title,
          description,
          status,
          createdAt,
          updatedAt,
          productId,
          tasks
        ]);

  @override
  String toString() {
    return 'Application { id: $id }';
  }
}
