import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginButtonPressed { email: $email, password: $password}';
  }
}

class LoginRegisterButtonPressed extends LoginEvent {
  LoginRegisterButtonPressed() : super([]);

  @override
  String toString() {
    return 'RegisterButtonPressed';
  }
}