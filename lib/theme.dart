import 'package:flutter/material.dart';

const _almostBlack = TextStyle(color: Colors.black87);
const _white = TextStyle(color: Colors.white);

// Awesome piece of code copy-pasted from https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  List strengths = [0.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });

  final materialColor = MaterialColor(color.value, swatch);
  print("MatColor for color $color: ${materialColor.shade900}");

  return materialColor;
}

/// Constructs customized light theme
ThemeData lightTheme(BuildContext context) {
  final primarySwatch = createMaterialColor(Color(0xfffefefe));

  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: primarySwatch,
    accentColor: Colors.amberAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: primarySwatch.shade700,
      textTheme: TextTheme(
        headline6: Theme.of(context).textTheme.headline6.merge(_almostBlack),
      ),
    ),
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
    primaryTextTheme: Theme.of(context).textTheme.merge(
          TextTheme(
            headline1: _almostBlack,
            headline2: _almostBlack,
            headline3: _almostBlack,
            headline4: _almostBlack,
            headline5: _almostBlack,
            headline6: _almostBlack,
          ),
        ),
  );
}

/// Constructs customized dark theme
ThemeData darkTheme(BuildContext context) {
  final primarySwatch = createMaterialColor(Color(0xff1a1a1a));

  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: primarySwatch,
    accentColor: Colors.amberAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.black87,
      textTheme: TextTheme(
        headline6: Theme.of(context).textTheme.headline6.merge(_white),
      ),
    ),
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
    primaryTextTheme: Theme.of(context).textTheme.merge(
          TextTheme(
            headline1: _white,
            headline2: _white,
            headline3: _white,
            headline4: _white,
            headline5: _white,
            headline6: _white,
          ),
        ),
  );
}
