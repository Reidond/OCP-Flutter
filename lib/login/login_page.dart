import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/login/index.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authBloc: _authBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(
        authBloc: _authBloc,
        loginBloc: _loginBloc,
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
