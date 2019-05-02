import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  @override
  ProductsState get initialState => InitialProductsState();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsState currentState,
    ProductsEvent event,
  ) async* {
    if (event is ProductsAppBarButtonPress) {
      yield InitialProductsState();
    }
  }
}
