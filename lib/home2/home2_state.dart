import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Home2State extends Equatable {
  Home2State([List props = const []]) : super(props);
}

class InitialHome2State extends Home2State {}

class ProductsDrawerButton extends Home2State {
  @override
  String toString() {
    return 'ProductsDrawerButton';
  }
}

class ApplicationsDrawerButton extends Home2State {
  @override
  String toString() {
    return 'ApplicationsDrawerButton';
  }
}
