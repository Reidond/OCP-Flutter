import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Theme.of(context).backgroundColor ==
                  ThemeData.light().backgroundColor
              ? Image.asset('assets/logo.png')
              : Image.asset('assets/logo_dark.png')),
    );
  }
}
