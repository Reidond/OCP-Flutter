import 'package:meta/meta.dart';
import 'package:open_copyright_platform/products/products_event.dart';

class Show extends ProductsEvent {
  final int id;

  Show({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'Show { $id }';
  }
}
