import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zelrap/data/models/account.dart';

class ApiService {
  final _authenticateUrl = "https://us-central1-zelrap-d452f.cloudfunctions.net/authenticate";
  final _streamUrl = "https://us-central1-zelrap-d452f.cloudfunctions.net/streamFeedCredentials";
  final _getUsers = "https://us-central1-zelrap-d452f.cloudfunctions.net/getUsers";

  Future<Account> login(String username) async {
    var authResponse = await http.post(_authenticateUrl, body: {'sender': username});
    var authToken = json.decode(authResponse.body)['authToken'];
    var feedResponse = await http.post(_streamUrl, headers: {'Authorization': 'Bearer $authToken'});
    var feedToken = json.decode(feedResponse.body)['token'];

    return Account(username: username, authToken: authToken, feedToken: feedToken);
  }
}
