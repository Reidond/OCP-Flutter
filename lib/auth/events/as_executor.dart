import 'package:meta/meta.dart';
import 'package:open_copyright_platform/auth/auth_event.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class AsExecutor extends AuthEvent {
  final User user;

  AsExecutor({@required this.user}) : super([user]);

  @override
  String toString() {
    return 'AsExecutor {isExecutor: ${user.userBody.isExecutor}}';
  }
}