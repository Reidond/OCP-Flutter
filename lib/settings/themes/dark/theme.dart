import 'package:flutter/material.dart';

import 'package:open_copyright_platform/settings/themes/dark/colors.dart';
import 'package:open_copyright_platform/settings/themes/gallery_theme.dart';

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: 'GoogleSans',
    ),
  );
}

ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: DARK_kPrimaryColor,
    secondary: DARK_kSecondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: DARK_kPrimaryColor,
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: DARK_kSecondaryColor,
    buttonColor: DARK_kPrimaryColor,
    indicatorColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: const Color(0xFF202124),
        brightness: Brightness.dark,
        elevation: 0.0),
    toggleableActiveColor: const Color(0xFF6997DF),
    accentColor: DARK_kSecondaryColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

final GalleryTheme kDarkGalleryTheme = GalleryTheme('Dark', _buildDarkTheme());