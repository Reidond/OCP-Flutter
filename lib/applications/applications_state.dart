import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ApplicationsState extends Equatable {
  ApplicationsState([List props = const []]) : super(props);
}

class ShowQuickSearch extends ApplicationsState {
  final String url;

  ShowQuickSearch({@required this.url}) : super([url]);

  @override
  String toString() {
    return 'ShowQuickSearch { $url }';
  }
}
