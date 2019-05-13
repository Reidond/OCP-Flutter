import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ApplicationsEvent extends Equatable {
  ApplicationsEvent([List props = const []]) : super(props);
}

class InitialApplicationsEvent extends ApplicationsEvent {
  @override
  String toString() {
    return 'InitialApplicationsEvent';
  }
}

class InitialApplicationShowEvent extends ApplicationsEvent {
  @override
  String toString() {
    return 'InitialApplicationShowEvent';
  }
}

class ApplicationFetch extends ApplicationsEvent {
  @override
  String toString() {
    return 'ApplicationFetch';
  }
}

class ApplicationShow extends ApplicationsEvent {
  final int id;

  ApplicationShow({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'ApplicationShow { $id }';
  }
}

class AddApplicationFABPress extends ApplicationsEvent {
  @override
  String toString() {
    return 'AddApplicationFABPress';
  }
}
