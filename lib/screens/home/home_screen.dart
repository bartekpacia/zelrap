import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/screens/home/widgets/featured_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, User"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xfffefefe),
              Color(0xffffffff),
//              Color(0xff1a1a1a),
//              Color(0xff000000),
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
                style: Theme.of(context).textTheme.headline6,
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
                style: Theme.of(context).textTheme.headline6,
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

        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            final name = snapshot.data.documents[index].data["name"];

            return FeaturedCard(name: name);
          },
        );
      },
    );
  }
}
