import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rails_api_connection/rails_api_connection.dart';
import './index.dart';

class ApplicationActionsBloc
    extends Bloc<ApplicationActionsEvent, ApplicationActionsState> {
  final ProductsActions productsActions;

  ApplicationActionsBloc({@required this.productsActions})
      : assert(productsActions != null);

  @override
  ApplicationActionsState get initialState => InitialApplicationActionsState();

  @override
  Stream<ApplicationActionsState> mapEventToState(
    ApplicationActionsEvent event,
  ) async* {
    if (event is WantToSelectProduct) {
      try {
        if (currentState is BottomSelectUninitialized) {
          final products = await productsActions.fetchProducts();
          yield BottomSelectLoaded(products: products);
        }
        if (currentState is BottomSelectLoaded) {
          final products = await productsActions.fetchProducts();
          yield BottomSelectLoaded(products: products);
        }
      } catch (_) {
        yield BottomSelectError();
      }
    }
    if (event is TapOnProductSelect) {
      final product = await productsActions.showProduct(event.id);
      yield ProductSelected(product: product);
    }
  }
}
