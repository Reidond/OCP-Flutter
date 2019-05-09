import 'dart:async';
import 'package:bloc/bloc.dart';
import './index.dart';

class Home2Bloc extends Bloc<Home2Event, Home2State> {
  @override
  Home2State get initialState => InitialHome2State();

  @override
  Stream<Home2State> mapEventToState(
    Home2Event event
  ) async* {
    if (event is InitialHome2) {
      yield InitialHome2State();
    }
    if (event is ProductsDrawerButtonPressed) {
      yield ProductsDrawerButton();
    }
    if (event is ApplicationsDrawerButtonPressed) {
      yield ApplicationsDrawerButton();
    }
  }
}
