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
  Future<List<dynamic>> _activities;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _activities = _getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Column(
              children: [
                TextField(controller: _messageController),
                MaterialButton(
                  onPressed: () => _postMessage(context),
                  child: Text("Post"),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder<List<dynamic>>(
            future: _activities,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
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
            }),
      ],
    );
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

  Future _postMessage(BuildContext context) async {
    if (_messageController.text.length > 0) {
      await ApiService().postMessage(widget.account, _messageController.text);
      Navigator.pop(context, true);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please type a message'),
        ),
      );
    }
  }
}
