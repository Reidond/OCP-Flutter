import 'package:flutter/material.dart';
import 'package:open_copyright_platform/authentication/index.dart';
import 'index.dart';

class SettingsPage extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final AuthenticationBloc authenticationBloc;

  SettingsPage({Key key, this.settingsBloc, this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () =>
                    settingsBloc.selectedTheme.add(_buildLightTheme()),
                child: Text(
                  'Light theme',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  onPressed: () =>
                      settingsBloc.selectedTheme.add(_buildDarkTheme()),
                  child: Text(
                    'Dark theme',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  onPressed: () => authenticationBloc.dispatch(LoggedOut()),
                  child: Text(
                    'Logout',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DemoTheme _buildLightTheme() {
    return DemoTheme('light', ThemeData.light());
  }

  DemoTheme _buildDarkTheme() {
    return DemoTheme('dark', ThemeData.dark());
  }
}
