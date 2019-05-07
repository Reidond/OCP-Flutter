import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './index.dart';

import 'package:rails_api_connection/rails_api_connection.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsActions productsActions;

  ProductsBloc({@required this.productsActions})
      : assert(productsActions != null);

  @override
  ProductsState get initialState => ProductsUninitialized();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsState currentState,
    ProductsEvent event,
  ) async* {
    if (event is InitialProductsEvent) {
      yield ProductsUninitialized();
    }
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProductsUninitialized) {
          final products = await productsActions.fetchPosts();
          yield ProductsLoaded(products: products, hasReachedMax: false);
        }
        if (currentState is ProductsLoaded) {
          final products = await productsActions.fetchPosts();
          yield products.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ProductsLoaded(products: products, hasReachedMax: true);
        }
      } catch (_) {
        yield ProductsError();
      }
    }
  }

  bool _hasReachedMax(ProductsState state) =>
      state is ProductsLoaded && state.hasReachedMax;
}
