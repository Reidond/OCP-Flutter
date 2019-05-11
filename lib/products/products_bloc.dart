import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import './index.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsActions productsActions;

  ProductsBloc({@required this.productsActions})
      : assert(productsActions != null);

  @override
  ProductsState get initialState => ProductsUninitialized();

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is InitialProductsEvent) {
      yield ProductsUninitialized();
    }
    if (event is InitialProductShowEvent) {
      yield ProductShowUninitialized();
    }
    if (event is Fetch) {
      try {
        if (currentState is ProductsUninitialized) {
          final products = await productsActions.fetchProducts();
          yield ProductsLoaded(products: products);
        }
        if (currentState is ProductsLoaded) {
          final products = await productsActions.fetchProducts();
          yield ProductsLoaded(products: products);
        }
        if (currentState is ProductShowed) {
          final products = await productsActions.fetchProducts();
          yield ProductsLoaded(products: products);
        }
        if (currentState is ProductShowLoaded) {
          final products = await productsActions.fetchProducts();
          yield ProductsLoaded(products: products);
        }
      } catch (_) {
        yield ProductsError();
      }
    }
    if (event is Show) {
      yield ProductShowed();
      try {
        if (currentState is ProductShowed) {
          final product = await productsActions.showProduct(event.id);
          yield ProductShowLoaded(product: product);
        }
        if (currentState is ProductsLoaded) {
          final products = await productsActions.fetchProducts();
          yield ProductsLoaded(products: products);
        }
      } catch (_) {
        yield ProductsError();
        yield ProductShowError();
      }
    }
  }
}
