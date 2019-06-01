import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:open_copyright_platform/auth/index.dart';
import 'package:open_copyright_platform/login/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authBloc,
  })  : assert(userRepository != null),
        assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        if (user.userBody.isExecutor) {
          authBloc.dispatch(AsExecutor(user: user));
        } else {
          authBloc.dispatch(LoggedIn(user: user));
        }
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is LoginRegisterButtonPressed) {
      yield LoginLoading();
      authBloc.dispatch(RegisterButtonPress());
    }
  }
}
