import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomAppBarState extends Equatable {
  BottomAppBarState([List props = const []]) : super(props);
}
