import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String description;
  final int productType;
  final String createdAt;
  final String updatedAt;

  Product(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.productType,
      this.createdAt,
      this.updatedAt})
      : super(
            [id, userId, name, description, productType, createdAt, updatedAt]);

  @override
  String toString() {
    return 'Post { id: $id }';
  }
}
