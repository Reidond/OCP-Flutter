import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DashBoardEvent extends Equatable {}

class InitialDashBoard extends DashBoardEvent {
  @override
  String toString() {
    return 'InitialDashBoard';
  }
}
