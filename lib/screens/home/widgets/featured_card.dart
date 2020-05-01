import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String name;

  const FeaturedCard({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(8),
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
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
