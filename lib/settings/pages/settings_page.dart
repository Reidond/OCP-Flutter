import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_copyright_platform/auth/index.dart';
import '../index.dart';

class SettingsPage extends StatelessWidget {
  final ThemeBloc themeBloc;
  final AuthBloc authBloc;

  SettingsPage({Key key, this.themeBloc, this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
          ),
        ),
        body: BlocBuilder(
            bloc: themeBloc,
            builder: (_, ThemeData theme) {
              return MaterialApp(
                theme: theme,
                home: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SettingsButton(
                          Icons.exit_to_app,
                          "Toogle dark mode",
                          "Make your experience better",
                          () => themeBloc.dispatch(ThemeEvent.toggle)),
                      SettingsButton(Icons.exit_to_app, "Logout",
                          "Tap to logout", () => authBloc.dispatch(LoggedOut()))
                    ],
                  ),
                ),
              );
            }));
  }
}
