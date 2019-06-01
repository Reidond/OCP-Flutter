import 'package:meta/meta.dart';
import 'package:open_copyright_platform/auth/auth_state.dart';

class AuthAsExecutor extends AuthState {
  final bool isExecutor;

  AuthAsExecutor({@required this.isExecutor}) : super([isExecutor]);

  @override
  String toString() {
    return 'AuthAsExecutor { $isExecutor }';
  }
}
