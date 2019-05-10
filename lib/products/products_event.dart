import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {}

class InitialProductsEvent extends ProductsEvent {
  @override
  String toString() {
    return 'InitialProductsEvent';
  }
}

class Fetch extends ProductsEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}

class Show extends ProductsEvent {
  @override
  String toString() {
    return 'Show';
  }
}