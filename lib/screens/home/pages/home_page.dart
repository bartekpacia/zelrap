import 'package:flutter/material.dart';
import 'package:zelrap/data/data_repository.dart';
import 'package:zelrap/data/models/person.dart';
import 'package:zelrap/screens/home/widgets/featured_card.dart';
import 'package:zelrap/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: buildHorizontalList(context, DataRepository.instance.listenLiveCelebrities()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 0, 24),
            child: Text(
              "📈 Fresh Talent",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: buildHorizontalList(context, DataRepository.instance.listenFreshCelebrities()),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalList(BuildContext context, Stream<List<Celebrity>> stream) {
    return StreamBuilder<List<Celebrity>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("An error occurred. ${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return LoadingIndicator();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemExtent: 176,
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            final celebrity = snapshot.data[index];

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
