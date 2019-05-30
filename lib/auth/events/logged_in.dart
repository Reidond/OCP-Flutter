import 'package:meta/meta.dart';
import 'package:open_copyright_platform/auth/auth_event.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class LoggedIn extends AuthEvent {
  final User user;

  LoggedIn({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'LoggedIn {headers: ${user.userHeaders}, body: ${user.userBody}}';
  }
}
