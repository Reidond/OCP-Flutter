import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsState extends Equatable {
  ProductsState([List props = const []]) : super(props);
}

class InitialProductsState extends ProductsState {
  @override
  String toString() {
    return 'InitialProductsState';
  }
}

class ProductsLoading extends InitialProductsState {
  @override
  String toString() {
    return 'ProductsLoading';
  }
}
