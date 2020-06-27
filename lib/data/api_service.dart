import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:zelrap/data/models/account.dart';

class ApiService {
  static const platform = const MethodChannel("pl.bartekpacia/zelrap");

  final _authenticateUrl = "https://us-central1-zelrap-d452f.cloudfunctions.net/authenticate";
  final _streamUrl = "https://us-central1-zelrap-d452f.cloudfunctions.net/streamFeedCredentials";
  final _getUsers = "https://us-central1-zelrap-d452f.cloudfunctions.net/getUsers";

  Future<Account> login(String username) async {
    var authResponse = await http.post(_authenticateUrl, body: {"sender": username});
    var authToken = json.decode(authResponse.body)["authToken"];
    var feedResponse = await http.post(_streamUrl, headers: {"Authorization": "Bearer $authToken"});
    var feedToken = json.decode(feedResponse.body)["token"];

    final account = Account(username: username, authToken: authToken, feedToken: feedToken);

    print("LOGGED IN. Account: $account");

    return account;
  }

  Future<List<dynamic>> getUsers(Account account) async {
    var response = await http.get(_getUsers);
    return json.decode(response.body)["users"];
  }

  Future<bool> follow(Account account, String userToFollow) async {
    return await platform.invokeMethod<bool>(
      "follow",
      {
        "user": account.username,
        "token": account.feedToken,
        "userToFollow": userToFollow,
      },
    );
  }

  Future<bool> postMessage(Account account, String message) async {
    return await platform.invokeMethod<bool>(
      "postMessage",
      {
        "user": account.username,
        "token": account.feedToken,
        "message": message,
      },
    );
  }

  Future<dynamic> getActivities(Account account) async {
    final String result = await platform.invokeMethod<String>(
      "getActivities",
      {
        "user": account.username,
        "token": account.feedToken,
      },
    );
    return json.decode(result);
  }

  Future<List<dynamic>> getTimeline(Account account) async {
    final String result = await platform.invokeMethod<String>(
      "getTimeline",
      {
        "user": account.username,
        "token": account.feedToken,
      },
    );

    return json.decode(result);
  }
}
