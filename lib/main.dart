import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/common/index.dart';
import 'package:open_copyright_platform/dashboard/index.dart';
import 'package:open_copyright_platform/login/index.dart';
import 'package:open_copyright_platform/register/index.dart';
import 'package:open_copyright_platform/settings/index.dart';
import 'package:open_copyright_platform/splash/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
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
  AuthBloc _authBloc;
  final ThemeBloc _themeBloc = ThemeBloc();
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authBloc = AuthBloc(userRepository: _userRepository);

    _authBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<AuthBloc>(bloc: _authBloc),
          BlocProvider<ThemeBloc>(bloc: _themeBloc)
        ],
        child: BlocBuilder(
            bloc: _themeBloc,
            builder: (_, ThemeData theme) {
              return MaterialApp(
                title: 'Open Copyright Platform',
                theme: theme,
                home: BlocBuilder<AuthEvent, AuthState>(
                  bloc: _authBloc,
                  builder: (BuildContext context, AuthState state) {
                    if (state is AuthUninitialized) {
                      return SplashPage();
                    }
                    if (state is AuthAuthenticated) {
                      return DashBoardPage();
                    }
                    if (state is AuthAsExecutor) {
                      return DashBoardPage();
                    }
                    if (state is AuthUnauthenticated) {
                      return LoginPage(userRepository: _userRepository);
                    }
                    if (state is AuthUnregistered) {
                      return RegisterPage(
                        userRepository: _userRepository,
                      );
                    }
                    if (state is AuthLoading) {
                      return LoadingIndicator();
                    }
                  },
                ),
              );
            }));
  }
}
