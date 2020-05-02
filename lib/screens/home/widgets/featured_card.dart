import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/data/models/person.dart';

class FeaturedCard extends StatelessWidget {
  final Celebrity celebrity;

  const FeaturedCard({Key key, @required this.celebrity}) : super(key: key);

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(celebrity.photoUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            celebrity.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
