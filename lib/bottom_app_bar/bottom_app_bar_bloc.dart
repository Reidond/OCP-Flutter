import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class BottomAppBarBloc extends Bloc<BottomAppBarEvent, BottomAppBarState> {
  @override
  BottomAppBarState get initialState => InitialBottomAppBarState();

  @override
  Stream<BottomAppBarState> mapEventToState(
      BottomAppBarState currentState, BottomAppBarEvent event) async* {
    if (event is InitialBottomAppBar) {
      yield InitialBottomAppBarState();
    }
    if (event is BottomAppBarAddProducts) {
      yield ProductsPageState();
    }
  }
}
