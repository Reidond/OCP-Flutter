import 'package:open_copyright_platform/applications/applications_state.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

class ApplicationsLoaded extends ApplicationsState {
  final List<Application> applications;

  ApplicationsLoaded({this.applications}) : super([applications]);

  ApplicationsLoaded copyWith({List<Application> applications}) {
    return ApplicationsLoaded(applications: applications ?? this.applications);
  }

  @override
  String toString() {
    return 'ApplicationsLoaded { applications: ${applications.length} }';
  }
}
