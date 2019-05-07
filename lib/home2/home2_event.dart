import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Home2Event extends Equatable {}

class ProductsDrawerButtonPressed extends Home2Event {
  @override
  String toString() {
    return 'ProductsDrawerButtonPressed';
  }
}

class ApplicationsDrawerButtonPressed extends Home2Event {
  @override
  String toString() {
    return 'ApplicationsDrawerButtonPressed';
  }
}

class InitialHome2 extends Home2Event {
  @override
  String toString() {
    return 'InitialHome2';
  }
}
