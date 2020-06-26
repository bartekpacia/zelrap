import 'package:flutter/cupertino.dart';

/// Account for Stream API
class Account {
  final String username;
  final String authToken;
  final String feedToken;

  Account({
    @required this.username,
    @required this.authToken,
    @required this.feedToken,
  });

  @override
  String toString() {
    return 'Account{username: $username, authToken: $authToken, feedToken: $feedToken}';
  }
}
