import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var firestore = Firestore.instance.collection("celebrities").getDocuments();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, User"),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("celebrities").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("An error occurred");
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Text(snapshot.data.documents[index].data["name"]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
