import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'LoggedIn {headers: ${user.userHeaders}, body: ${user.userBody}}';
  }
}

class RegisteredIn extends AuthenticationEvent {
  final User user;

  RegisteredIn({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'RegisteredIn {headers: ${user.userHeaders}, body: ${user.userBody}}';
  }
}

class RegisterButtonPress extends AuthenticationEvent {
  RegisterButtonPress() : super();

  @override
  String toString() {
    return 'RegisterButtonPress';
  }
}

class LoginButtonPress extends AuthenticationEvent {
  LoginButtonPress() : super();

  @override
  String toString() {
    return 'LoginButtonPress';
  }
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoggedOut';
  }
}
