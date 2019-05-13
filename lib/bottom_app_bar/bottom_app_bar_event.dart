import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomAppBarEvent extends Equatable {}

class ShowAddProductsFAB extends BottomAppBarEvent {
  @override
  String toString() {
    return 'ShowAddProductsFAB';
  }
}

class ShowAddApplicationsFAB extends BottomAppBarEvent {
  @override
  String toString() {
    return 'ShowAddApplicationsFAB';
  }
}

class InitialBottomAppBar extends BottomAppBarEvent {
  @override
  String toString() {
    return 'InitialBottomAppBar';
  }
}
