import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ApplicationActionsEvent extends Equatable {
  ApplicationActionsEvent([List props = const []]) : super(props);
}

class WantToSelectProduct extends ApplicationActionsEvent {
  @override
  String toString() {
    return 'WantToSelectProduct';
  }
}
