import 'package:flutter/material.dart';
import 'package:zelrap/screens/home_screen.dart';
import 'package:zelrap/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zelpar',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: HomeScreen(),
    );
  }
}
