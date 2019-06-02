import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_copyright_platform/settings/themes/dark/theme.dart';
import 'package:open_copyright_platform/settings/themes/light/theme.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => kLightGalleryTheme.data;

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield currentState == kDarkGalleryTheme.data
            ? kLightGalleryTheme.data
            : kDarkGalleryTheme.data;
        break;
    }
  }
}
