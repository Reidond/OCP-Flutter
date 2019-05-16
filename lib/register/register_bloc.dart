import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/register/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authBloc,
  })  : assert(userRepository != null),
        assert(authBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        final user = await userRepository.register(
            email: event.email,
            password: event.password,
            passwordConfirmation: event.passwordConfirmation);

        authBloc.dispatch(RegisteredIn(user: user));
        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
    if (event is RegisterLoginButtonPressed) {
      yield RegisterLoading();
      authBloc.dispatch(LoginButtonPress());
    }
  }
}
