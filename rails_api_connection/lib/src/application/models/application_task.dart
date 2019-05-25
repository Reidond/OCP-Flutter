import 'package:equatable/equatable.dart';

class ApplicationTask extends Equatable {
  final int id;
  final int copyrightApplicationId;
  final String title;
  final bool done;
  final String createdAt;
  final String updatedAt;

  ApplicationTask(
      {this.id,
      this.copyrightApplicationId,
      this.title,
      this.done,
      this.createdAt,
      this.updatedAt})
      : super([id, copyrightApplicationId, title, done, createdAt, updatedAt]);

  @override
  String toString() {
    return title;
  }
}
