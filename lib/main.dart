import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/background_notifications.dart';
import 'package:zelrap/screens/home/home_screen.dart';
import 'package:zelrap/theme.dart';

void main() {
  runApp(ZelrapApp());
}

class ZelrapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebaseMessaging = FirebaseMessaging();

    print("build APP");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotificationDialog(context, message);
      },
      onBackgroundMessage: backgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );

    return MaterialApp(
      title: 'Zelpar',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: HomeScreen(),
    );
  }

  void _showNotificationDialog(BuildContext context, Map<String, dynamic> message) async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    final alertDialog = AlertDialog(
      title: Text(message["title"]),
      content: Text(message["content"]),
      actions: [okButton],
    );

    await showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }
}
