import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterButtonPressed(
      {@required this.email,
      @required this.password,
      @required this.passwordConfirmation})
      : super([email, password, passwordConfirmation]);

  @override
  String toString() {
    return 'RegisterButtonPressed { email: $email, password: $password, passwordConfirmation: $passwordConfirmation}';
  }
}

class RegisterLoginButtonPressed extends RegisterEvent {
  RegisterLoginButtonPressed() : super([]);

  @override
  String toString() {
    return 'RegisterLoginButtonPressed';
  }
}
