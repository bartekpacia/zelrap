import 'package:flutter/material.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

class ProfilePage extends StatefulWidget {
  final Account account;

  const ProfilePage({Key key, @required this.account}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List> _activities;

  @override
  void initState() {
    super.initState();
    _activities = _getActivities();
  }

  Future<List<dynamic>> _getActivities() async {
    return await ApiService().getActivities(widget.account);
  }

  Future _refreshActivities() async {
    setState(() {
      _activities = _getActivities();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _activities,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("ProfilePage: no data"));
        }

        return Container(
          child: Center(
            child: RefreshIndicator(
              onRefresh: _refreshActivities,
              child: ListView(
                children: snapshot.data
                    .map((activity) => ListTile(
                          title: Text(activity['message']),
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
