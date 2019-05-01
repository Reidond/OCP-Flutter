import 'package:meta/meta.dart';

import 'user_body.dart';
import 'user_headers.dart';

class User {
  final UserBody userBody;
  final UserHeaders userHeaders;

  User({@required this.userBody, @required this.userHeaders});
}
