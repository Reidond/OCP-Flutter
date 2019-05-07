import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomAppBarEvent extends Equatable {}

class BottomAppBarAddProducts extends BottomAppBarEvent {
  @override
  String toString() {
    return 'BottomAppBarAddProducts';
  }
}

class InitialBottomAppBar extends BottomAppBarEvent {
  @override
  String toString() {
    return 'InitialBottomAppBar';
  }
}
