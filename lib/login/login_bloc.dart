import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:open_copyright_platform/authentication/index.dart';
import 'package:open_copyright_platform/login/index.dart';
import 'package:open_copyright_platform/register/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is LoginRegisterButtonPressed) {
      yield LoginLoading();
      authenticationBloc.dispatch(RegisterButtonPress());
    }
  }
}
