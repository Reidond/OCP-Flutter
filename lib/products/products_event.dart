import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  ProductsEvent([List props = const []]) : super(props);
}

class ProductsAppBarButtonPress {
  ProductsAppBarButtonPress() : super();

  @override
  String toString() {
    return 'ProductsAppBarButtonPress';
  }
}
