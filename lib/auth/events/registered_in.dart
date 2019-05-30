import 'package:meta/meta.dart';
import 'package:open_copyright_platform/auth/auth_event.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class RegisteredIn extends AuthEvent {
  final User user;

  RegisteredIn({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'RegisteredIn {headers: ${user.userHeaders}, body: ${user.userBody}}';
  }
}
