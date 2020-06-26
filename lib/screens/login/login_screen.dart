import 'package:flutter/material.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Stream"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: _userController,
                  ),
                  RaisedButton(
                    onPressed: () => _login(context),
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _login(BuildContext context) async {
    if (_userController.text.length > 0) {
      final Account account = await ApiService().login(_userController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(account: account),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username (length == 0)'),
        ),
      );
    }
  }
}
