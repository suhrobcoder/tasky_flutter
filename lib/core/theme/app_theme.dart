import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
  primarySwatch: createMaterialColor(primaryColor),
  brightness: Brightness.light,
  fontFamily: "Avenir",
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);

const primaryColor = Color(0xFF00E1B5);
const subtitleTextColor = Color(0xFF8B8B8B);
const lightGrey = Color(0xFFCECECE);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[0.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

extension TextThemeExt on BuildContext {
  TextTheme getTextTheme() {
    return Theme.of(this).textTheme;
  }
}
