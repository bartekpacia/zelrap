import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/data/models/notification_item.dart';
import 'package:zelrap/screens/home/home_screen.dart';
import 'package:zelrap/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ZelrapApp());
}

class ZelrapApp extends StatefulWidget {
  @override
  _ZelrapAppState createState() => _ZelrapAppState();
}

class _ZelrapAppState extends State<ZelrapApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final navigatorKey = GlobalKey<NavigatorState>();

  /// Constructs an AlertDialog ready to be shown.
  Widget _buildDialog(BuildContext context, NotificationItem item) {
    return AlertDialog(
      title: Text(item.title),
      content: Text(item.body),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  /// Shows AlertDialog with data from the FCM notification.
  void _showNotificationItemDialog(Map<String, dynamic> message) {
    final context = navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, NotificationItem.fromFCM(message)),
    );
  }

  @override
  void initState() {
    super.initState();

    final topicName = 'live_updates';

    _firebaseMessaging
        .subscribeToTopic(topicName)
        .then((value) => print('subscribed to topic $topicName'));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotificationItemDialog(message.data);

      print('MESSAGING: got a message whilst in the foreground!');
      print('MESSAGING: message data: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('MESSAGING: opened app from a notification');
      print('MESSAGING: data: ${message.data}');
    });

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    _firebaseMessaging
        .requestPermission(
      alert: true,
      sound: true,
      badge: true,
      provisional: true,
    )
        .then((NotificationSettings settings) {
      print('Notification settings: $settings');
    });

    _firebaseMessaging.getToken().then((String? token) {
      print('FCM token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Zelrap',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('onBackgroundMessage: $message');
}
