import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/data/notification_item.dart';
import 'package:zelrap/data/person.dart';
import 'package:zelrap/screens/home/widgets/featured_card.dart';
import 'package:zelrap/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text("Hi, User"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 0, 24),
              child: Text(
                "💃🏻 Live Right Now",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: buildHorizontalList(
                context,
                Firestore.instance
                    .collection("celebrities")
                    .where("isLive", isEqualTo: true)
                    .snapshots(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 0, 24),
              child: Text(
                "📈 Fresh Talent",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: buildHorizontalList(
                context,
                Firestore.instance
                    .collection("celebrities")
                    .where("joinedDate",
                        isGreaterThanOrEqualTo:
                            DateTime(DateTime.now().year, DateTime.now().month - 1))
                    .snapshots(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalList(BuildContext context, Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("An error occurred");
        }

        if (!snapshot.hasData) {
          return LoadingIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemExtent: 176,
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data.documents[index].data;
            final celebrity = Celebrity(
              name: doc["name"],
              photoUrl: doc["photo"],
              joinedDate: doc["joinedDate"].toDate(),
              isLive: doc["isLive"],
            );

            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FeaturedCard(celebrity: celebrity),
            );
          },
        );
      },
    );
  }
}
