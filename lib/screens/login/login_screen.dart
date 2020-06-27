import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zelrap/data/api_service.dart';
import 'package:zelrap/data/models/account.dart';
import 'package:zelrap/widgets/google_sign_in_button.dart';

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
                  GoogleSignInButton(
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

  Future<FirebaseUser> _handleSignIn(BuildContext context) async {
    if (_userController.text.length < 1) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username (length == 0)'),
        ),
      );
      return null;
    }

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(_userController.text);
    final Account account = await ApiService().login(_userController.text);

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(account: account),
      ),
    );

    return user;
  }
}
