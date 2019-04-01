import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:open_copyright_platform/authentication/index.dart';
import 'package:open_copyright_platform/login/index.dart';
import 'package:open_copyright_platform/register/index.dart';

class RegisterForm extends StatefulWidget {
  final RegisterBloc registerBloc;
  final AuthenticationBloc authenticationBloc;

  RegisterForm({
    Key key,
    @required this.registerBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  RegisterBloc get _registerBloc => widget.registerBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterEvent, RegisterState>(
        bloc: _registerBloc,
        builder: (
          BuildContext context,
          RegisterState state,
        ) {
          if (state is RegisterFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          _emailController.text = 'customer3@test.com';
          _passwordController.text = 'customer123';
          _passwordConfirmationController.text = 'customer123';

          return Form(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    // TODO: Make this check better
                    Theme.of(context).backgroundColor ==
                            ThemeData.light().backgroundColor
                        ? Image.asset('assets/logo.png')
                        : Image.asset('assets/logo_dark.png')
                  ],
                ),
                SizedBox(height: 120.0),
                TextField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.blue,
                    border: new OutlineInputBorder(),
                  ),
                  controller: _emailController,
                ),
                SizedBox(height: 12.0),
                TextField(
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.blue,
                    border: new OutlineInputBorder(),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                TextField(
                  decoration: new InputDecoration(
                    labelText: "Password confirmation",
                    fillColor: Colors.blue,
                    border: new OutlineInputBorder(),
                    //fillColor: Colors.green
                  ),
                  controller: _passwordConfirmationController,
                  obscureText: true,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Log In'),
                      onPressed: state is! RegisterLoading
                          ? _onRegisterLoginButtonPressed
                          : null,
                    ),
                    RaisedButton(
                      child: Text('Register'),
                      onPressed: state is! RegisterLoading
                          ? _onRegisterButtonPressed
                          : null,
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: state is RegisterLoading
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

  _onRegisterButtonPressed() {
    _registerBloc.dispatch(RegisterButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirmation: _passwordConfirmationController.text,
    ));
  }

  _onRegisterLoginButtonPressed() {
    _registerBloc.dispatch(RegisterLoginButtonPressed());
  }
}
