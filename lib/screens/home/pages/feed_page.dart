import 'package:flutter/material.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

class FeedPage extends StatefulWidget {
  final Account account;

  const FeedPage({Key key, @required this.account}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Message"),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                  ),
                  MaterialButton(
                    onPressed: () => _postMessage(context),
                    child: Text("Post"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
