import 'package:flutter/material.dart';

const _almostBlack = TextStyle(color: Colors.black87);
const _white = TextStyle(color: Colors.white);

/// Constructs customized light theme
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
    accentColor: Colors.amberAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      textTheme: TextTheme(
        headline6: Theme.of(context).textTheme.headline6.merge(_almostBlack),
      ),
    ),
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
    primaryTextTheme: Theme.of(context).primaryTextTheme.merge(
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
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
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
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
    primaryTextTheme: Theme.of(context).primaryTextTheme.merge(
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
