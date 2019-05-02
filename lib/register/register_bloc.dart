import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:open_copyright_platform/authentication/index.dart';
import 'package:open_copyright_platform/register/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
      RegisterState currentState, RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        final user = await userRepository.register(
            email: event.email,
            password: event.password,
            passwordConfirmation: event.passwordConfirmation);

        authenticationBloc.dispatch(RegisteredIn(user: user));
        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
    if (event is RegisterLoginButtonPressed) {
      yield RegisterLoading();
      authenticationBloc.dispatch(LoginButtonPress());
    }
  }
}
