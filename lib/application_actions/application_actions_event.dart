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
  final List<Map<String, String>> tasks;

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
