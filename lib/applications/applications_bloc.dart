import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_copyright_platform/application_actions/index.dart';
import 'package:open_copyright_platform/applications/index.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

import './index.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ApplicationActionsBloc applicationActionsBloc;
  final ApplicationActions applicationActions;
  StreamSubscription applicationActionsBlocSubscription;

  ApplicationsBloc(this.applicationActionsBloc,
      {@required this.applicationActions})
      : assert(applicationActions != null);

  @override
  void dispose() {
    //applicationActionsBlocSubscription.cancel();
    super.dispose();
  }

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
        if (currentState is ShowQuickSearch) {
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
    if (event is DeleteApplication) {
      final bool isDeleted =
          await applicationActions.deleteApplication(event.id);
      if (isDeleted) {
        yield ApplicationsUninitialized();
        dispatch(FetchApplications());
      } else {
        yield ApplicationsError();
      }
    }
    if (event is WantToSearch) {
      final String urlToShow =
          await applicationActions.quickSearch(event.productId);
      yield ShowQuickSearch(url: urlToShow);
    }
  }
}
