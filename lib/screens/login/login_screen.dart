import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                    controller: _userController,
                  ),
                  RaisedButton(
                    child: Text("Sign in"),
                    onPressed: () => _handleSignIn(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext context) async {
    if (_userController.text.length < 1) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username (length == 0)'),
        ),
      );
      return null;
    }

    final Account account = await ApiService().login(_userController.text);

    print("signed in $account}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(account: account),
      ),
    );
  }
}
