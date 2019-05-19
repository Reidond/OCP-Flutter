import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

@immutable
abstract class ApplicationActionsState extends Equatable {
  ApplicationActionsState([List props = const []]) : super(props);
}

class InitialApplicationActionsState extends ApplicationActionsState {}

class ProductNotSelected extends ApplicationActionsState {
  @override
  String toString() {
    return 'ProductNotSelected';
  }
}

class ProductSelected extends ApplicationActionsState {
  final Product product;

  ProductSelected({this.product}) : super([product]);

  ProductSelected copyWith({Application product}) {
    return ProductSelected(product: product ?? this.product);
  }

  @override
  String toString() {
    return 'ProductSelected { product: ${product.name} }';
  }
}

class BottomSelectUninitialized extends ApplicationActionsState {
  @override
  String toString() {
    return 'BottomSelectUninitialized';
  }
}

class BottomSelectLoaded extends ApplicationActionsState {
  final List<Product> products;

  BottomSelectLoaded({this.products}) : super([products]);

  BottomSelectLoaded copyWith({List<Product> products}) {
    return BottomSelectLoaded(products: products ?? this.products);
  }

  @override
  String toString() {
    return 'BottomSelectLoaded { products: ${products.length} }';
  }
}

class BottomSelectError extends ApplicationActionsState {
  @override
  String toString() {
    return 'BottomSelectUninitialized';
  }
}
