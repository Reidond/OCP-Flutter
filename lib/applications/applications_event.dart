import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ApplicationsEvent extends Equatable {
  ApplicationsEvent([List props = const []]) : super(props);
}

class DeleteApplication extends ApplicationsEvent {
  final int id;

  DeleteApplication({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'DeleteApplication { $id }';
  }
}

class WantToSearch extends ApplicationsEvent {
  final int productId;

  WantToSearch({@required this.productId}) : super([productId]);

  @override
  String toString() {
    return 'WantToSearch { $productId }';
  }
}
