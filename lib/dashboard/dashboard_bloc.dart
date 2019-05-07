import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  @override
  DashBoardState get initialState => InitialDashBoardState();

  @override
  Stream<DashBoardState> mapEventToState(
    DashBoardState currentState,
    DashBoardEvent event,
  ) async* {
    if (event is InitialDashBoard) {
      yield InitialDashBoardState();
    }
  }
}
