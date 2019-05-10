import 'package:equatable/equatable.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

abstract class ProductsState extends Equatable {
  ProductsState([List props = const []]) : super(props);
}

class ProductsUninitialized extends ProductsState {
  @override
  String toString() {
    return 'ProductsUninitialized';
  }
}

class ProductsError extends ProductsState {
  @override
  String toString() {
    return 'ProductsError';
  }
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded({this.products})
      : super([products]);

  ProductsLoaded copyWith({List<Product> products}) {
    return ProductsLoaded(
        products: products ?? this.products);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${products.length} }';
  }
}

class ProductShowed extends ProductsState {
  @override
  String toString() {
    return 'ProductShowed';
  }
}