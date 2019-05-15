import 'package:meta/meta.dart';
import 'package:open_copyright_platform/applications/applications_event.dart';

class ApplicationShow extends ApplicationsEvent {
  final int id;

  ApplicationShow({@required this.id}) : super([id]);

  @override
  String toString() {
    return 'ApplicationShow { $id }';
  }
}
