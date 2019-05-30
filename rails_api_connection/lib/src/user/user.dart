import 'package:meta/meta.dart';

import 'package:rails_api_connection/src/user/user_body.dart';
import 'package:rails_api_connection/src/user/user_headers.dart';

class User {
  final UserBody userBody;
  final UserHeaders userHeaders;

  User({@required this.userBody, @required this.userHeaders});
}
