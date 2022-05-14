import 'package:flutter/material.dart';

MaterialColor createMaterialColor(int hexColor) {
  final r = hexColor >> 16 & 0xff;
  final g = hexColor >> 8 & 0xff;
  final b = hexColor & 0xff;
  final swatch = <int, Color>{};

  final strengths = <double>[.05];
  strengths.addAll(List.generate(9, (i) => 0.1 * i));
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(0xff << 24 | hexColor, swatch);
}
