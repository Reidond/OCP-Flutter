import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:open_copyright_platform/authentication/index.dart';
import 'package:open_copyright_platform/login/index.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          if (state is LoginFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          // _emailController.text = 'customer1@test.com';
          // _passwordController.text = 'customer123';

          return Form(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    Theme.of(context).backgroundColor ==
                            ThemeData.light().backgroundColor
                        ? Image.asset('assets/logo.png')
                        : Image.asset('assets/logo_dark.png')
                  ],
                ),
                SizedBox(height: 120.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.blue,
                    border: new OutlineInputBorder(),
                  ),
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
// spacer
                SizedBox(height: 12.0),
// [Password]
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.blue,
                    border: new OutlineInputBorder(),
                    //fillColor: Colors.green
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Register'),
                      onPressed: state is! LoginLoading
                          ? _onRegisterButtonPressed
                          : null,
                    ),
                    RaisedButton(
                      child: Text('Log In'),
                      onPressed:
                          state is! LoginLoading ? _onLoginButtonPressed : null,
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: state is LoginLoading
                          ? CircularProgressIndicator()
                          : null,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  _onRegisterButtonPressed() {
    _loginBloc.dispatch(LoginRegisterButtonPressed());
  }
}
