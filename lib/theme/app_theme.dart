import 'package:flutter/material.dart';
import 'package:komikoo/theme/color_schemes.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      colorScheme: isDark ? darkColorScheme : lightColorScheme,
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
    );
  }
}
