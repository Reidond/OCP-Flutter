import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomAppBarState extends Equatable {
  BottomAppBarState([List props = const []]) : super(props);
}

class InitialBottomAppBarState extends BottomAppBarState {}

class ShowAddProductsFABState extends BottomAppBarState {
  @override
  String toString() {
    return 'ShowAddProductsFABState';
  }
}

class ShowAddApplicationsFABState extends BottomAppBarState {
  @override
  String toString() {
    return 'ShowAddApplicationsFABState';
  }
}
