import 'package:rails_api_connection/rails_api_connection.dart';
import 'package:open_copyright_platform/applications/applications_state.dart';

class ApplicationShowLoaded extends ApplicationsState {
  final Application application;

  ApplicationShowLoaded({this.application}) : super([application]);

  ApplicationShowLoaded copyWith({Application application}) {
    return ApplicationShowLoaded(application: application ?? this.application);
  }

  @override
  String toString() {
    return 'ApplicationShowLoaded { application: ${application.title} }';
  }
}
