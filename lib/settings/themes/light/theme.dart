import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_copyright_platform/settings/themes/gallery_theme.dart';
import 'package:open_copyright_platform/settings/themes/light/colors.dart';

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title
        .copyWith(fontFamily: 'GoogleSans', color: LIGHT_kPrimaryTextColor),
  );
}

ThemeData _buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: LIGHT_kPrimaryColor,
    primaryVariant: LIGHT_kPrimaryDarkColor,
    secondary: LIGHT_kSecondaryColor,
    secondaryVariant: LIGHT_kSecondaryDarkColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: LIGHT_kPrimaryColor,
    primaryColorDark: LIGHT_kPrimaryDarkColor,
    primaryColorLight: LIGHT_kPrimaryLightColor,
    buttonColor: LIGHT_kPrimaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: LIGHT_kPrimaryLightColor,
    appBarTheme: AppBarTheme(
        color: Colors.white, brightness: Brightness.light, elevation: 0.0),
    bottomAppBarColor: LIGHT_kPrimaryColor,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: LIGHT_kSecondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: LIGHT_kErrorColor,
    iconTheme: IconThemeData(color: LIGHT_kPrimaryTextColor),
    primaryIconTheme: IconThemeData(color: LIGHT_kPrimaryTextColor),
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

final GalleryTheme kLightGalleryTheme =
    GalleryTheme('Light', _buildLightTheme());
