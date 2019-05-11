import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_copyright_platform/settings/theme/theme.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => ThemeData.dark();

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield currentState == ThemeData.dark()
            ? ThemeData.light()
            : ThemeData.dark();
        break;
    }
  }
}
