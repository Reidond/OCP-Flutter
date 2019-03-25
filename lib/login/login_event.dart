import 'dart:async';
import 'package:open_copyright_platform/login/index.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({@required this.username, @required this.password})
      : super([username, password]);

  @override
  String toString() {
    return 'LoginButtonPressed { username: $username, password: $password}';
  }
}
