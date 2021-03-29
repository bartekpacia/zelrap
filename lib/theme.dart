import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return _build(
      brightness: Brightness.light,
      primary: Colors.amberAccent,
      lighterText: Colors.white,
      darkerText: Colors.black,
      surface: Colors.white,
      background: const Color(0xFFF1F1F1),
      error: const Color(0xFFD32F2F),
      onError: Colors.white,
    );
  }

  static ThemeData dark() {
    return _build(
      brightness: Brightness.dark,
      primary: Colors.amberAccent,
      lighterText: Colors.white,
      darkerText: Colors.white,
      //surface: Colors.red,
      surface: const Color(0xFF222222),
      //background: Colors.blue,
      background: const Color(0xFF121212),
      error: const Color(0xFFEA9A9A),
      onError: Colors.black,
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color lighterText,
    required Color darkerText,
    required Color surface,
    required Color background,
    required Color error,
    required Color onError,
  }) {
    final isDark = brightness == Brightness.dark;

    final defaultTextTheme = isDark
        ? Typography.material2018(platform: defaultTargetPlatform).white
        : Typography.material2018(platform: defaultTargetPlatform).black;

    final darkPrimary = Color(0xff4d7b00);

    final theme = ThemeData.from(
      colorScheme: ColorScheme(
        primary: primary,
        primaryVariant: isDark ? darkPrimary : primary,
        secondary: primary,
        secondaryVariant: darkPrimary,
        surface: surface,
        background: background,
        error: error,
        onPrimary: darkerText,
        onSecondary: lighterText,
        onSurface: darkerText,
        onBackground: darkerText,
        onError: onError,
        brightness: brightness,
      ),
      textTheme: defaultTextTheme.copyWith(
        bodyText2: defaultTextTheme.bodyText2?.copyWith(
          fontSize: 16,
        ),
      ),
    );

    final buttonColor = isDark ? darkerText : Color.lerp(primary, darkerText, 0.8);

    return theme.copyWith(
      primaryColorDark: darkPrimary,
      bottomAppBarColor: isDark ? surface : primary,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}