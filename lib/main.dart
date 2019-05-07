import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:open_copyright_platform/authentication/index.dart';
import 'package:open_copyright_platform/bottom_app_bar/index.dart';
import 'package:open_copyright_platform/home2/index.dart';
import 'package:open_copyright_platform/register/index.dart';
import 'package:open_copyright_platform/splash/index.dart';
import 'package:open_copyright_platform/login/index.dart';
import 'package:open_copyright_platform/dashboard/index.dart';
import 'package:open_copyright_platform/common/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);

    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc)
      ],
      child: MaterialApp(
        title: 'Open Copyright Platform',
        theme: ThemeData.dark(),
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return DashBoardPage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: _userRepository);
            }
            if (state is AuthenticationUnregistered) {
              return RegisterPage(
                userRepository: _userRepository,
              );
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
