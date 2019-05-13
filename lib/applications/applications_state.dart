import 'package:equatable/equatable.dart';
import 'package:rails_api_connection/rails_api_connection.dart';

abstract class ApplicationsState extends Equatable {
  ApplicationsState([List props = const []]) : super(props);
}

class ApplicationsUninitialized extends ApplicationsState {
  @override
  String toString() {
    return 'ProductsUninitialized';
  }
}

class ApplicationsError extends ApplicationsState {
  @override
  String toString() {
    return 'ProductsError';
  }
}

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

class ApplicationShowUninitialized extends ApplicationsState {
  @override
  String toString() {
    return 'ProductShowUninitialized';
  }
}

class ApplicationShowError extends ApplicationsState {
  @override
  String toString() {
    return 'ProductShowError';
  }
}

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

class ApplicationShowed extends ApplicationsState {
  @override
  String toString() {
    return 'ApplicationShowed';
  }
}

class AddApplicationFABPressed extends ApplicationsState {
  @override
  String toString() {
    return 'AddApplicationFABPressed';
  }
}
