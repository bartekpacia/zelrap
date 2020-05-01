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
        elevation: 0,
        title: Text("Hi, User"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
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
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("celebrities").snapshots(),
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
              ),
            ),
            Expanded(
              child: Text("dupa"),
            )
          ],
        ),
      ),
    );
  }
}
