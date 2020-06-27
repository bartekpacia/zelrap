import 'package:flutter/material.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

class PeoplePage extends StatefulWidget {
  final Account account;

  const PeoplePage({Key key, @required this.account}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  Future<List> _users;

  @override
  void initState() {
    super.initState();
    _users = ApiService().getUsers(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _users,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("PeoplePage: no data"));
        }

        return ListView(
          children: snapshot.data
              .where((u) => u != widget.account.username)
              .map((u) => ListTile(
                    title: Text(u),
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(content: Text("Click to follow"), actions: [
                          FlatButton(
                            child: const Text(
                              'Follow',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              await ApiService().follow(widget.account, u);
                              Navigator.pop(context, "Followed");
                            },
                          )
                        ]),
                      ).then<void>(
                        (String message) {
                          // The value passed to Navigator.pop() or null.
                          if (message != null) {
                            Scaffold.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                          }
                        },
                      );
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
