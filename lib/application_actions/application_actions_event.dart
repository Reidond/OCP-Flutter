import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

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

class TapOnProductSelect extends ApplicationActionsEvent {
  final int id;

  TapOnProductSelect({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'TapOnProductSelect { $id }';
  }
}

class CreateApplication extends ApplicationActionsEvent {
  final String productId;
  final String title;
  final String description;
  final List<ApplicationTask> tasks;

  CreateApplication(
      {@required this.productId,
      @required this.title,
      @required this.description,
      @required this.tasks})
      : super([productId, title, description, tasks]);

  @override
  String toString() {
    return 'CreateApplication { $productId, $title, $description }';
  }
}

class SubmitApplication extends ApplicationActionsEvent {
  final int id;

  SubmitApplication({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'SubmitApplication { $id }';
  }
}

class UnSubmitApplication extends ApplicationActionsEvent {
  final int id;

  UnSubmitApplication({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'UnSubmitApplication { $id }';
  }
}
