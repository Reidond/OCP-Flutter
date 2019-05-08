import 'dart:async';
import './index.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<DemoTheme> selectedTheme;

  factory SettingsBloc() {
    final selectedTheme = PublishSubject<DemoTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);
    return SettingsBloc._(themeDataStream, selectedTheme);
  }

  const SettingsBloc._(this.themeDataStream, this.selectedTheme);

  DemoTheme initialTheme() {
    return DemoTheme('initial', ThemeData.dark());
  }
}
