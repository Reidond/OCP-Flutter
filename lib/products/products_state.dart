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
  final bool hasReachedMax;

  ProductsLoaded({this.products, this.hasReachedMax})
      : super([products, hasReachedMax]);

  ProductsLoaded copyWith({List<Product> products, bool hasReachedMax}) {
    return ProductsLoaded(
        products: products ?? this.products,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return 'ProductsLoaded { products: ${products.length}, hasReachedMax: $hasReachedMax }';
  }
}
