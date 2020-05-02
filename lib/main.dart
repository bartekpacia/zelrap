import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Represents a notification coming from FCM
class NotificationItem {
  final String title;
  final String body;
  final dynamic data;

  NotificationItem({@required this.title, @required this.body, @required this.data});

  /// Creates a notification using data received from FCM
  factory NotificationItem.fromFCM(Map<String, dynamic> message) {
    final String title = message["notification"]["title"];
    final String body = message["notification"]["body"];
    final dynamic data = message["data"];

    final NotificationItem item = NotificationItem(title: title, body: body, data: data);
    return item;
  }
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Messaging Demo'),
      ),
      body: Center(
        child: Text("hello word"),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PushMessagingExample(),
    ),
  );
}
