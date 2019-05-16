import 'package:meta/meta.dart';
import 'package:open_copyright_platform/applications/applications_event.dart';

class ShowApplication extends ApplicationsEvent {
  final int id;

  ShowApplication({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'ShowApplication { $id }';
  }
}
