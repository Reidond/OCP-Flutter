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

  ProductsLoaded({this.products}) : super([products]);

  ProductsLoaded copyWith({List<Product> products}) {
    return ProductsLoaded(products: products ?? this.products);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${products.length} }';
  }
}

class ProductShowUninitialized extends ProductsState {
  @override
  String toString() {
    return 'ProductShowUninitialized';
  }
}

class ProductShowError extends ProductsState {
  @override
  String toString() {
    return 'ProductShowError';
  }
}

class ProductShowLoaded extends ProductsState {
  final Product product;

  ProductShowLoaded({this.product}) : super([product]);

  ProductShowLoaded copyWith({Product product}) {
    return ProductShowLoaded(product: product ?? this.product);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${product.name} }';
  }
}

class ProductShowed extends ProductsState {
  @override
  String toString() {
    return 'ProductShowed';
  }
}
