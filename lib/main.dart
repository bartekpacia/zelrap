import 'package:flutter/material.dart';
import 'package:zelrap/screens/home/home_screen.dart';
import 'package:zelrap/theme.dart';

void main() {
  runApp(ZelrapApp());
}

class ZelrapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zelrap',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: HomeScreen(),
    );
  }
}
