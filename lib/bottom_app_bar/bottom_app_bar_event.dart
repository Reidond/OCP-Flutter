import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomAppBarEvent extends Equatable {
  BottomAppBarEvent([List props = const []]) : super(props);
}

class BottomAppBarAddProducts extends BottomAppBarEvent {
  BottomAppBarAddProducts() : super([]);

  @override
  String toString() {
    return 'BottomAppBarAddProducts';
  }
}

class InitialBottomAppBar extends BottomAppBarEvent {
  InitialBottomAppBar() : super([]);

  @override
  String toString() {
    return 'InitialBottomAppBar';
  }
}
