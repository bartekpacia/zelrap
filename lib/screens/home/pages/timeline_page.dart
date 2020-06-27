import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

class TimelinePage extends StatefulWidget {
  final Account account;

  const TimelinePage({Key key, @required this.account}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  Future<List<dynamic>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = _getTimeline();
  }

  Future<List<dynamic>> _getTimeline() async {
    return await ApiService().getTimeline(widget.account);
  }

  Future _refreshActivities() async {
    setState(() {
      _activities = _getTimeline();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _activities,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("TimelinePage: no data"));
        }

        return Container(
          child: Center(
            child: RefreshIndicator(
              onRefresh: _refreshActivities,
              child: ListView(
                children: snapshot.data
                    .map((activity) => ListTile(
                          title: Text(activity['message']),
                          subtitle: Text(activity['actor']),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
