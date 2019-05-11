import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ProductsEvent extends Equatable {
  ProductsEvent([List props = const []]) : super(props);
}

class InitialProductsEvent extends ProductsEvent {
  @override
  String toString() {
    return 'InitialProductsEvent';
  }
}

class InitialProductShowEvent extends ProductsEvent {
  @override
  String toString() {
    return 'InitialProductShowEvent';
  }
}

class Fetch extends ProductsEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}

class Show extends ProductsEvent {
  final int id;

  Show({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'Show { $id }';
  }
}
