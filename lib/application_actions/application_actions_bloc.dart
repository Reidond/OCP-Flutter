import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class ApplicationActionsBloc
    extends Bloc<ApplicationActionsEvent, ApplicationActionsState> {
  @override
  ApplicationActionsState get initialState => InitialApplicationActionsState();

  @override
  Stream<ApplicationActionsState> mapEventToState(
    ApplicationActionsEvent event,
  ) async* {}
}
