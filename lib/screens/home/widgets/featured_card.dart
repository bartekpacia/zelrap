import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String name;

  const FeaturedCard({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      color: Theme.of(context).primaryColor,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xffeeeeee),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Text(name),
      ),
    );
  }
}
