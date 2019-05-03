import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {}

class Fetch extends ProductsEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}
