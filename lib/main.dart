import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/data/models/notification_item.dart';
import 'package:zelrap/screens/home/home_screen.dart';
import 'package:zelrap/theme.dart';

void main() {
  runApp(ZelrapApp());
}

class ZelrapApp extends StatefulWidget {
  @override
  _ZelrapAppState createState() => _ZelrapAppState();
}

class _ZelrapAppState extends State<ZelrapApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final navigatorKey = GlobalKey<NavigatorState>();

  Widget _buildDialog(BuildContext context, NotificationItem item) {
    return AlertDialog(
      title: Text(item.title),
      content: Text(item.body),
      actions: <Widget>[
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    final context = navigatorKey.currentState.overlay.context;

    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, NotificationItem.fromFCM(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: _handleBackgroundMessage,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true),
    );

    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      print("FCM token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Zelrap',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: HomeScreen(),
    );
  }
}

Future<void> _handleBackgroundMessage(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
}
