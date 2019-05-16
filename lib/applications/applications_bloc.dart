import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import './index.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ApplicationActions applicationActions;

  ApplicationsBloc({@required this.applicationActions})
      : assert(applicationActions != null);

  @override
  ApplicationsState get initialState => ApplicationsUninitialized();

  @override
  Stream<ApplicationsState> mapEventToState(ApplicationsEvent event) async* {
    if (event is ApplicationsInit) {
      yield ApplicationsUninitialized();
    }
    if (event is ShowApplicationInit) {
      yield ApplicationShowUninitialized();
    }
    if (event is FetchApplications) {
      try {
        if (currentState is ApplicationsUninitialized) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
        if (currentState is ApplicationsLoaded) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
        if (currentState is ApplicationShowed) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
        if (currentState is ApplicationShowLoaded) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
        if (currentState is AddApplicationFABPressed) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
      } catch (_) {
        yield ApplicationsError();
      }
    }
    if (event is ShowApplication) {
      yield ApplicationShowed();
      try {
        if (currentState is ApplicationShowed) {
          final application =
              await applicationActions.showApplication(event.id);
          yield ApplicationShowLoaded(application: application);
        }
        if (currentState is ApplicationsLoaded) {
          final applications = await applicationActions.fetchApplications();
          yield ApplicationsLoaded(applications: applications);
        }
      } catch (_) {
        yield ApplicationShowError();
      }
    }
    if (event is AddApplication) {
      yield AddApplicationFABPressed();
    }
  }
}
