import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import './index.dart';

class ApplicationActionsBloc
    extends Bloc<ApplicationActionsEvent, ApplicationActionsState> {
  final ProductsActions productsActions;
  final ApplicationActions applicationActions;

  ApplicationActionsBloc(
      {@required this.productsActions, @required this.applicationActions})
      : assert(productsActions != null && applicationActions != null);

  @override
  ApplicationActionsState get initialState => BottomSelectUninitialized();

  @override
  Stream<ApplicationActionsState> mapEventToState(
    ApplicationActionsEvent event,
  ) async* {
    if (event is WantToSelectProduct) {
      try {
        yield BottomSelectUninitialized();
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
      applicationActions.storeProductId(id: event.id);
      yield ProductSelected(product: product);
    }
    if (event is CreateApplication) {
      var application = new ApplicationDao(
          productId: event.productId,
          title: event.title,
          description: event.description,
          tasks: event.tasks);

      final isCreated =
          await applicationActions.createApplication(body: application.toMap());

      if (isCreated) {
        yield ApplicationCreated();
      } else {
        yield ApplicationNotCreated();
      }
    }
    if (event is SubmitApplication) {
      final int newStatus = await applicationActions
          .changeApplicationStatus(event.id, submit: true);
      yield ApplicationStatusChanged(currentStatus: newStatus);
    }
    if (event is UnSubmitApplication) {
      final int newStatus = await applicationActions
          .changeApplicationStatus(event.id, submit: false);
      yield ApplicationStatusChanged(currentStatus: newStatus);
    }
  }
}
