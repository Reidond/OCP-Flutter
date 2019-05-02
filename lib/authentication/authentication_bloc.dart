import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:open_copyright_platform/authentication/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationState currentState, AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasHeaders = await userRepository.hasHeaders();

      if (hasHeaders) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistHeaders(event.user);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteHeaders();
      yield AuthenticationUnauthenticated();
    }

    if (event is RegisteredIn) {
      yield AuthenticationLoading();
      await userRepository.persistHeaders(event.user);
      yield AuthenticationAuthenticated();
    }

    if (event is RegisterButtonPress) {
      yield AuthenticationUnregistered();
    }

    if (event is LoginButtonPress) {
      yield AuthenticationUnauthenticated();
    }
  }
}
