import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
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
      ),
    );
  }
}
