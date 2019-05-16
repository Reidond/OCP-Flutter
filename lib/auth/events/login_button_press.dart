import 'package:open_copyright_platform/auth/auth_event.dart';

class LoginButtonPress extends AuthEvent {
  LoginButtonPress() : super();

  @override
  String toString() {
    return 'LoginButtonPress';
  }
}
